part of 'evento_costumbre_participa_cubit.dart';

abstract class EventosCostumbresParticipaState extends Equatable {
  final List<EventoCostumbreParticipaEntity>? eventosCostumbresParticipa;

  const EventosCostumbresParticipaState({this.eventosCostumbresParticipa});

  @override
  List<Object> get props => [];
}

class EventosCostumbresParticipaInitial
    extends EventosCostumbresParticipaState {}

class EventosCostumbresParticipaLoading
    extends EventosCostumbresParticipaState {}

class EventosCostumbresParticipaLoaded extends EventosCostumbresParticipaState {
  final List<EventoCostumbreParticipaEntity>? eventosCostumbresParticipaLoaded;

  const EventosCostumbresParticipaLoaded(this.eventosCostumbresParticipaLoaded)
      : super(eventosCostumbresParticipa: eventosCostumbresParticipaLoaded);
}

class EventosCostumbresParticipaError extends EventosCostumbresParticipaState {
  final String message;

  const EventosCostumbresParticipaError(this.message);
}
