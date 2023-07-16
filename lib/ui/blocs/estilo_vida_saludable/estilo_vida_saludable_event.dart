part of 'estilo_vida_saludable_bloc.dart';

abstract class EstiloVidaSaludableEvent extends Equatable {
  const EstiloVidaSaludableEvent();

  @override
  List<Object> get props => [];
}

class EstiloVidaSaludableInit extends EstiloVidaSaludableEvent {}

class EstiloVidaSaludableSubmitted extends EstiloVidaSaludableEvent {
  final EstiloVidaSaludableEntity estiloVidaSaludable;

  const EstiloVidaSaludableSubmitted(this.estiloVidaSaludable);
}

class GetEstiloVidaSaludable extends EstiloVidaSaludableEvent {
  final int afiliadoId;

  const GetEstiloVidaSaludable(this.afiliadoId);
}

class EstiloVidaSaludableFormSubmissionSuccess
    extends EstiloVidaSaludableEvent {
  final int ubicacionId;

  const EstiloVidaSaludableFormSubmissionSuccess(this.ubicacionId);
}

class EstiloVidaSaludableFormSubmissionFailed extends EstiloVidaSaludableEvent {
  final String message;

  const EstiloVidaSaludableFormSubmissionFailed(this.message);
}

class ActividadFisicaChanged extends EstiloVidaSaludableEvent {
  final int actividadFisicaId;

  const ActividadFisicaChanged(this.actividadFisicaId);
}

class AlimentacionChanged extends EstiloVidaSaludableEvent {
  final int alimentacionId;

  const AlimentacionChanged(this.alimentacionId);
}

class ConsumeCigarrilloChanged extends EstiloVidaSaludableEvent {
  final int consumeCigarrillo;

  const ConsumeCigarrilloChanged(this.consumeCigarrillo);
}

class NumeroCigarrillosDiaChanged extends EstiloVidaSaludableEvent {
  final int numeroCigarrilloDiaId;

  const NumeroCigarrillosDiaChanged(this.numeroCigarrilloDiaId);
}

class ConsumoAlcoholChanged extends EstiloVidaSaludableEvent {
  final int consumoAlcoholId;

  const ConsumoAlcoholChanged(this.consumoAlcoholId);
}

class ConsumoSustanciasChanged extends EstiloVidaSaludableEvent {
  final int consumoSustanciasPsicoactivas;

  const ConsumoSustanciasChanged(this.consumoSustanciasPsicoactivas);
}
