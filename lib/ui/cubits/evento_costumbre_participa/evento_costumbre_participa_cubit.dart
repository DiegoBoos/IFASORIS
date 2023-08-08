import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/evento_costumbre_participa_model.dart';
import '../../../domain/entities/evento_costumbre_participa_entity.dart';
import '../../../domain/usecases/evento_costumbre_participa/evento_costumbre_participa_db_usecase.dart';

part 'evento_costumbre_participa_state.dart';

class EventoCostumbreParticipaCubit
    extends Cubit<EventosCostumbresParticipaState> {
  final EventoCostumbreParticipaUsecaseDB eventoCostumbreParticipaUsecaseDB;

  EventoCostumbreParticipaCubit(
      {required this.eventoCostumbreParticipaUsecaseDB})
      : super(EventosCostumbresParticipaInitial());

  void getEventosCostumbresParticipaDB() async {
    final result = await eventoCostumbreParticipaUsecaseDB
        .getEventosCostumbresParticipaUsecaseDB();
    result.fold(
        (failure) =>
            emit(EventosCostumbresParticipaError(failure.properties.first)),
        (data) => emit(EventosCostumbresParticipaLoaded(data)));
  }

  Future<List<LstEventoCostumbreParticipa>> getAsp6EventosCostumbresParticipaDB(
      int? dimensionSocioCulturalPueblosIndigenasId) async {
    final result = await eventoCostumbreParticipaUsecaseDB
        .getAsp6EventosCostumbresParticipaUsecaseDB(
            dimensionSocioCulturalPueblosIndigenasId);
    return result.fold((failure) => [], (data) => data);
  }
}
