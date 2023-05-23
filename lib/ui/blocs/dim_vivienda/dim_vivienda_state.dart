part of 'dim_vivienda_bloc.dart';

abstract class DimViviendaState {
  const DimViviendaState();
}

class DimViviendaFormInitial extends DimViviendaState {
  const DimViviendaFormInitial();
}

class DimViviendaFormLoaded extends DimViviendaState {}

class DimViviendaFormEmpty extends DimViviendaState {}

class DimViviendaSubmissionSuccess extends DimViviendaState {}

class DimViviendaSubmissionFailed extends DimViviendaState {
  final String message;

  DimViviendaSubmissionFailed(this.message);
}

DimViviendaEntity initObject() {
  //TODO: Revisar init object
  return DimViviendaEntity(
      datoViviendaId: 0,
      familiaId: 0,
      tipoViviendaId: 0,
      tenenciaViviendaId: 0,
      pisosViviendaIds: [],
      otroTipoPiso: '',
      techosViviendaIds: [],
      otroTipoTecho: '',
      ventilacionViviendaId: 0,
      iluminacionViviendaId: 0,
      serviciosPublicosViviendaIds: [],
      tratamientosAguaViviendaIds: [],
      tiposSanitarioViviendaIds: [],
      otroTipoSanitario: '',
      tiposCombustibleViviendaIds: [],
      otroTipoCombustible: '',
      factoresRiesgoViviendaIds: [],
      presenciaAnimalesViviendaIds: [],
      otroPresenciaAnimal: '');
}
