import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/services/shared_preferences_service.dart';

import '../../../data/models/afiliado.dart';
import '../../../domain/entities/afiliado.dart';

part 'afiliado_prefs_event.dart';
part 'afiliado_prefs_state.dart';

class AfiliadoPrefsBloc extends Bloc<AfiliadoPrefsEvent, AfiliadoPrefsState> {
  final SharedPreferencesService sharedPreferencesService;
  AfiliadoPrefsBloc({
    required this.sharedPreferencesService,
  }) : super(AfiliadoPrefsInitial()) {
    on<SaveAfiliado>((event, emit) {
      final afiliadoModel = AfiliadoModel.fromEntity(event.afiliado);
      sharedPreferencesService.saveAfiliadoToSharedPreferences(afiliadoModel);

      final afiliadoJson = sharedPreferencesService.getJson('afiliado');

      if (afiliadoJson != null) {
        AfiliadoModel afiliado = AfiliadoModel.fromDB(afiliadoJson);

        emit(AfiliadoPrefsLoaded(afiliado));
      } else {
        emit(AfiliadoPrefsInitial());
      }
    });

    on<LoadAfiliado>((event, emit) {
      final Map<String, dynamic> afiliadoStr =
          sharedPreferencesService.getJson('afiliado');

      if (afiliadoStr.isNotEmpty) {
        AfiliadoModel afiliado = AfiliadoModel.fromDB(afiliadoStr);

        emit(AfiliadoPrefsLoaded(afiliado));
      } else {
        emit(AfiliadoPrefsInitial());
      }
    });
    on<DeleteAfiliado>((event, emit) {
      sharedPreferencesService.delete('afiliado');
      emit(AfiliadoPrefsInitial());
    });
  }
}
