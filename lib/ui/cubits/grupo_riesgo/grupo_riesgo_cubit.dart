import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/usecases/grupo_riesgo/grupo_riesgo_exports.dart';

part 'grupo_riesgo_state.dart';

class GrupoRiesgoCubit extends Cubit<GruposRiesgoState> {
  final GrupoRiesgoUsecaseDB grupoRiesgoUsecaseDB;

  GrupoRiesgoCubit({required this.grupoRiesgoUsecaseDB})
      : super(GruposRiesgoInitial());

  void getGruposRiesgoDB() async {
    final result = await grupoRiesgoUsecaseDB.getGruposRiesgoUsecase();
    result.fold((failure) => emit(GruposRiesgoError(failure.properties.first)),
        (data) => emit(GruposRiesgoLoaded(data)));
  }
}
