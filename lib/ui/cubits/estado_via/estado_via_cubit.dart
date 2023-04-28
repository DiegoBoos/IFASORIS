import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/usecases/estado_via/estado_via_db_usecase.dart';

import '../../../domain/entities/estado_via_entity.dart';

part 'estado_via_state.dart';

class EstadoViaCubit extends Cubit<EstadosViasState> {
  final EstadoViaUsecaseDB estadoViaUsecaseDB;
  EstadoViaCubit({required this.estadoViaUsecaseDB})
      : super(EstadosViasInitial());

  void getEstadosVias() async {
    final result = await estadoViaUsecaseDB.getEstadosViasUsecase();
    result.fold((failure) => emit(EstadosViasError(failure.properties.first)),
        (data) => emit(EstadosViasLoaded(data)));
  }
}
