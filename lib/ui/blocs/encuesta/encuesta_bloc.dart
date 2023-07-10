import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/grupo_familiar_entity.dart';

part 'encuesta_event.dart';
part 'encuesta_state.dart';

class EncuestaBloc extends Bloc<EncuestaEvent, EncuestaState> {
  EncuestaBloc() : super(EncuestaState()) {
    on<SaveAfiliadosEncuesta>((event, emit) {
      emit(state.copyWith(afiliados: event.afiliadosGrupoFamiliar));
    });
    on<UpdatePercentage>((event, emit) {
      emit(state.copyWith(newPercentage: event.newPercentage));
    });
  }
}
