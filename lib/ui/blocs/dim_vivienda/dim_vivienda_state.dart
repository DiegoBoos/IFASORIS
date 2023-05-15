part of 'dim_vivienda_bloc.dart';

abstract class DimViviendaState {
  const DimViviendaState();
}

class FormInitial extends DimViviendaState {
  const FormInitial();
}

class FormLoaded extends DimViviendaState {}

class FormEmpty extends DimViviendaState {}

class SubmissionSuccess extends DimViviendaState {}

class SubmissionFailed extends DimViviendaState {
  final String message;

  SubmissionFailed(this.message);
}

DimViviendaEntity initObject() {
  return DimViviendaEntity(
      datoViviendaId: 0,
      familiaId: 0,
      tipoViviendaId: 0,
      tenenciaViviendaId: 0,
      pisoViviendaId: 0,
      otroTipoPiso: '',
      techoViviendaId: 0,
      otroTipoTecho: '',
      ventilacionViviendaId: 0,
      iluminacionViviendaId: 0,
      servicioPublicoViviendaId: 0,
      tratamientoAguaViviendaId: 0,
      tipoSanitarioViviendaId: 0,
      otroTipoSanitario: '',
      tipoCombustibleViviendaId: 0,
      otroTipoCombustible: '',
      factorRiesgoViviendaId: 0,
      presenciaAnimalViviendaId: 0,
      otroPresenciaAnimal: 0);
}
