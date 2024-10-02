import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/app_config.dart';
import '../../../core/constants.dart';
import '../../../data/models/afiliado.dart';
import '../../../data/models/sync_progress.dart';
import '../../../domain/usecases/afiliado/afiliado_exports.dart';
import '../../../domain/usecases/ficha/ficha_exports.dart';
import '../../../services/shared_preferences_service.dart';

part 'sync_event.dart';
part 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final AfiliadoUsecase afiliadoUsecase;
  final AfiliadoUsecaseDB afiliadoUsecaseDB;
  final FichaUsecase fichaUsecase;
  final FichaUsecaseDB fichaUsecaseDB;

  final prefs = SharedPreferencesService();

  int successfulAfiliadoInserts = 0;

  List<FichaEntity> fichasTemp = [];
  int countRecordsFichasTemp = 0;

  SyncBloc({
    required this.afiliadoUsecase,
    required this.afiliadoUsecaseDB,
    required this.fichaUsecase,
    required this.fichaUsecaseDB,
  }) : super(SyncInitial()) {
    on<InitSync>((event, emit) => emit(SyncInitial()));
    on<SyncStarted>((event, emit) async {
      if (event.type == 'A') {
        add(Downloading(state.syncProgressModel.copyWith(
          title: 'Descargando afiliados',
        )));

        await syncAfiliados(event);
      } else if (event.type == 'P') {
        await uploadFichas(event);
      }
    });
    on<Downloading>((event, emit) => emit(SyncDownloading(event.syncProgress)));
    on<SyncPercentageChanged>((event, emit) {
      event.syncProgress.counter == event.syncProgress.total
          ? emit(SyncSuccess())
          : emit(SyncPercentageInProgress(event.syncProgress));
    });
    on<SyncIncrementChanged>((event, emit) {
      event.syncProgress.counter == event.syncProgress.total
          ? emit(SyncSuccess())
          : emit(SyncIncrementInProgress(event.syncProgress));
    });
    on<SyncError>((event, emit) => emit(SyncFailure(event.message)));
  }

  int calculatePercent(int counter, int total) {
    final percent = ((counter / total) * 100).toInt();
    return percent;
  }

// ************************** Ficha ****************************
  Future<void> uploadFichas(
    SyncStarted event,
  ) async {
    final completer = Completer<void>();

    final result = await fichaUsecase.createFichaUsecase();
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      final uri = Uri.parse('${AppConfig.syncPublica}/ficha');
      final fichasSync = [];

      for (var i = 0; i < data.length; i++) {
        final fichaIdLocal = data[i]['Ficha_id'];
        final ficha = data[i];

        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/data.json');

        // Escribe la cadena JSON en el archivo
        await file.writeAsString(jsonEncode(ficha));

        final syncProgressModel = state.syncProgressModel.copyWith(
          title: 'Sincronizando Ficha',
          counter: i + 1,
          total: data.length,
          percent: calculatePercent(i, data.length),
        );

        add(Downloading(syncProgressModel));
        ficha['Ficha_id'] = 0; // Para nueva Ficha se envia id 0
        final resp = await http.post(uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${prefs.token}',
            },
            body: jsonEncode(ficha));

        final Map<String, dynamic> decodedResp = jsonDecode(resp.body);
        if (resp.statusCode == 200 || resp.statusCode == 201) {
          final fichaRemote = decodedResp['ficha'];
          fichasSync.add(ficha);

          await fichaUsecaseDB.updateFichaUsecaseDB(
              fichaIdLocal, fichaRemote['numFicha']);

          add(SyncIncrementChanged(state.syncProgressModel.copyWith(
            title: 'Se sincronizaron: ${fichasSync.length} fichas',
          )));
        } else {
          add(SyncError(decodedResp['message']));
        }
      }
    });
  }
// ************************** Ficha ****************************

// ************************** Afiliados ****************************
  Future<void> syncAfiliados(SyncStarted event) async {
    int limit = 5000;
    int municipioId = event.user.userMetadata!['Municipio_id'];
    List<dynamic> afiliadosMap = [];
    List<Map<String, dynamic>> combinedList = [];

    final requestUrl =
        Uri.parse('${AppConfig.syncPublica}/afiliados/$municipioId/$limit');

    final resp = await http.get(requestUrl);

    if (resp.statusCode == 200) {
      final decodedResp = json.decode(resp.body);
      final int totalRecords = decodedResp['totalRecords'];
      final int loopValue = decodedResp['loopValue'];

      for (var i = 0; i < loopValue; i++) {
        final afiliadosUrl = Uri.parse(
            '${AppConfig.syncPublica}/afiliados/afiliadosbympio?limit=$limit&page=$i&mpioId=$municipioId');
        final afiliadosResp = await http.get(afiliadosUrl);

        if (afiliadosResp.statusCode == 200) {
          final decodeReq = json.decode(afiliadosResp.body);
          afiliadosMap.addAll(decodeReq);
        } else {
          add(const SyncError(unexpectedErrorMessage));
        }

        final syncProgressModel = state.syncProgressModel.copyWith(
          title: 'Descargando afiliados',
          counter: i,
          total: loopValue,
          percent: calculatePercent(i + 1, loopValue),
        );

        add(Downloading(syncProgressModel));
      }

      combinedList =
          afiliadosMap.map((e) => e as Map<String, dynamic>).toList();

      final afiliadoResp = {
        "totalRecords": totalRecords,
        "afiliados": combinedList
      };

      await saveAfiliados(event, AfiliadoResponseModel.fromJson(afiliadoResp));
    } else {
      add(const SyncError(unexpectedErrorMessage));
    }
  }

  Future<void> saveAfiliados(
      SyncStarted event, AfiliadoResponseModel afiliadosRes) async {
    final completer = Completer<void>();

    for (int i = 0; i < afiliadosRes.resultado.length; i++) {
      final afiliado = afiliadosRes.resultado[i];

      final saveAfiliado =
          await afiliadoUsecaseDB.saveAfiliadoUsecaseDB(afiliado);

      saveAfiliado.fold((failure) {
        add(SyncError(failure.properties.first));
        completer.completeError(failure);
      }, (_) {
        final syncProgressModel = state.syncProgressModel.copyWith(
          title: 'Sincronizando afiliados',
          counter: i + 1,
          percent: calculatePercent(i + 1, afiliadosRes.resultado.length - 1),
        );

        add(Downloading(syncProgressModel));
      });
    }

    if (!completer.isCompleted) {
      await syncFichas(event);
      completer.complete();
    }

    return completer.future;
  }

// ************************** Afiliados ****************************

// ************************** Fichas ****************************

  Future<void> syncFichas(SyncStarted event) async {
    final completer = Completer<void>();

    String userName = event.user.userMetadata!['UserName'];
    final result = await fichaUsecase.getFichasUsecase(userName);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      fichasTemp.addAll(data);
      add(SyncIncrementChanged(state.syncProgressModel.copyWith(
          title: 'Sincronizando fichas',
          counter: state.syncProgressModel.counter + 1,
          total: state.syncProgressModel.totalAccesorias)));

      if (fichasTemp.isNotEmpty) {
        countRecordsFichasTemp = 0;
        await saveFichas(
          event,
          fichasTemp[countRecordsFichasTemp],
        );
      } else {
        if (!completer.isCompleted) {
          add(SyncIncrementChanged(state.syncProgressModel.copyWith(
              title: 'Sincronización completada',
              counter: state.syncProgressModel.counter + 1,
              total: state.syncProgressModel.totalAccesorias)));
          completer.complete();
        }
      }
    });

    return completer.future;
  }

  Future<void> saveFichas(
    SyncStarted event,
    FichaEntity ficha,
  ) async {
    final completer = Completer<void>();

    final result = await fichaUsecaseDB.createFichaCompletaUsecaseDB(ficha);
    result.fold((failure) {
      add(SyncError(failure.properties.first));
      completer.completeError(failure);
    }, (data) async {
      countRecordsFichasTemp++;
      if (countRecordsFichasTemp >= fichasTemp.length) {
        return;
      }

      FichaEntity fichaTemp = fichasTemp[countRecordsFichasTemp];
      await saveFichas(
        event,
        fichaTemp,
      );

      if (!completer.isCompleted) {
        completer.complete();
      }
    });

    return completer.future;
  }
}
