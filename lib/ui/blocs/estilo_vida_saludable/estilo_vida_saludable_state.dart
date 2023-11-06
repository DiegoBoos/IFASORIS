part of 'estilo_vida_saludable_bloc.dart';

abstract class EstiloVidaSaludableState {
  const EstiloVidaSaludableState();
}

class EstiloVidaSaludableFormInitial extends EstiloVidaSaludableState {
  const EstiloVidaSaludableFormInitial();
}

class EstiloVidaSaludableFormLoading extends EstiloVidaSaludableState {}

class EstiloVidaSaludableFormEmpty extends EstiloVidaSaludableState {}

class EstiloVidaSaludableFormLoaded extends EstiloVidaSaludableState {}

class EstiloVidaSaludableSubmissionSuccess extends EstiloVidaSaludableState {}

class EstiloVidaSaludableSubmissionFailed extends EstiloVidaSaludableState {
  final String message;

  EstiloVidaSaludableSubmissionFailed(this.message);
}

EstiloVidaSaludableEntity initObject() {
  return EstiloVidaSaludableEntity(
      formStatus: const EstiloVidaSaludableFormInitial());
}
