import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/afiliado/afiliado_exports.dart';
import 'package:ifasoris/services/shared_preferences_service.dart';

import '../../../data/models/afiliado_response_model.dart';

part 'afiliado_prefs_event.dart';
part 'afiliado_prefs_state.dart';

class AfiliadoPrefsBloc extends Bloc<AfiliadoPrefsEvent, AfiliadoPrefsState> {
  final SharedPreferencesService sharedPreferencesService;
  AfiliadoPrefsBloc({required this.sharedPreferencesService})
      : super(AfiliadoInitial()) {
    on<SaveAfiliado>((event, emit) {
      // Persist data to shared preferences
      sharedPreferencesService.setJson('afiliado', event.afiliado);

      final afiliadoJson = sharedPreferencesService.getJson('afiliado');

      if (afiliadoJson != null) {
        AfiliadoModel afiliado = AfiliadoModel.fromJson(afiliadoJson);

        // Emit new state with loaded data
        emit(AfiliadoLoaded(afiliado));
      } else {
        emit(AfiliadoInitial());
      }
    });

    on<LoadAfiliado>((event, emit) {
      // Retrieve data from shared preferences

      final Map<String, dynamic> afiliadoStr =
          sharedPreferencesService.getJson('afiliado');

      if (afiliadoStr.isNotEmpty) {
        AfiliadoModel afiliado = AfiliadoModel.fromJson(afiliadoStr);

        // Emit new state with loaded data
        emit(AfiliadoLoaded(afiliado));
      } else {
        emit(AfiliadoInitial());
      }
    });
    on<DeleteAfiliado>((event, emit) {
      sharedPreferencesService.delete('afiliado');
      emit(AfiliadoInitial());
    });
  }
}
