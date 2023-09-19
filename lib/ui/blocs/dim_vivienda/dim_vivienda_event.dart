part of 'dim_vivienda_bloc.dart';

abstract class DimViviendaEvent extends Equatable {
  const DimViviendaEvent();

  @override
  List<Object> get props => [];
}

class DimViviendaInit extends DimViviendaEvent {}

class DimViviendaSubmitted extends DimViviendaEvent {}

class GetDimVivienda extends DimViviendaEvent {
  final int familiaId;

  const GetDimVivienda(this.familiaId);
}

class DimViviendaFormSubmissionSuccess extends DimViviendaEvent {
  final int datoViviendaId;

  const DimViviendaFormSubmissionSuccess(this.datoViviendaId);
}

class DimViviendaFormSubmissionFailed extends DimViviendaEvent {
  final String message;

  const DimViviendaFormSubmissionFailed(this.message);
}

class DimViviendaFamiliaChanged extends DimViviendaEvent {
  final int familiaId;

  const DimViviendaFamiliaChanged(this.familiaId);
}

class TipoViviendaChanged extends DimViviendaEvent {
  final int tipoViviendaId;

  const TipoViviendaChanged(this.tipoViviendaId);
}

class TenenciaViviendaChanged extends DimViviendaEvent {
  final int tenenciaViviendaId;

  const TenenciaViviendaChanged(this.tenenciaViviendaId);
}

class NroCuartoViviendaChanged extends DimViviendaEvent {
  final int nroCuartosViviendaId;

  const NroCuartoViviendaChanged(this.nroCuartosViviendaId);
}

class PisosViviendaChanged extends DimViviendaEvent {
  final List<LstPiso> lstPiso;

  const PisosViviendaChanged(this.lstPiso);
}

class TechosViviendaChanged extends DimViviendaEvent {
  final List<LstTecho> lstTecho;

  const TechosViviendaChanged(this.lstTecho);
}

class VentilacionViviendaChanged extends DimViviendaEvent {
  final int ventilacionViviendaId;

  const VentilacionViviendaChanged(this.ventilacionViviendaId);
}

class IluminacionViviendaChanged extends DimViviendaEvent {
  final int iluminacionViviendaId;

  const IluminacionViviendaChanged(this.iluminacionViviendaId);
}

class GetTechosVivienda extends DimViviendaEvent {
  final int? datoViviendaId;

  const GetTechosVivienda(this.datoViviendaId);
}

class GetServiciosPublicosVivienda extends DimViviendaEvent {
  final int? datoViviendaId;

  const GetServiciosPublicosVivienda(this.datoViviendaId);
}

class GetTratamientosAguaVivienda extends DimViviendaEvent {
  final int? datoViviendaId;

  const GetTratamientosAguaVivienda(this.datoViviendaId);
}

class GetTiposSanitarioVivienda extends DimViviendaEvent {
  final int? datoViviendaId;

  const GetTiposSanitarioVivienda(this.datoViviendaId);
}

class GetTiposCombustibleVivienda extends DimViviendaEvent {
  final int? datoViviendaId;

  const GetTiposCombustibleVivienda(this.datoViviendaId);
}

class GetFactoresRiesgoVivienda extends DimViviendaEvent {
  final int? datoViviendaId;

  const GetFactoresRiesgoVivienda(this.datoViviendaId);
}

class GetPisosVivienda extends DimViviendaEvent {
  final int? datoViviendaId;

  const GetPisosVivienda(this.datoViviendaId);
}

class GetPresenciaAnimales extends DimViviendaEvent {
  final int? datoViviendaId;

  const GetPresenciaAnimales(this.datoViviendaId);
}

class ServiciosPublicosViviendaChanged extends DimViviendaEvent {
  final List<LstServPublico> lstServPublico;

  const ServiciosPublicosViviendaChanged(this.lstServPublico);
}

class TratamientosAguaViviendaChanged extends DimViviendaEvent {
  final List<LstTmtoAgua> lstTmtoAgua;

  const TratamientosAguaViviendaChanged(this.lstTmtoAgua);
}

class TiposSanitarioViviendaChanged extends DimViviendaEvent {
  final List<LstTipoSanitario> lstTipoSanitario;

  const TiposSanitarioViviendaChanged(this.lstTipoSanitario);
}

class TiposCombustibleViviendaChanged extends DimViviendaEvent {
  final List<LstTipoCombustible> lstTipoCombustible;

  const TiposCombustibleViviendaChanged(this.lstTipoCombustible);
}

class FactoresRiesgoViviendaChanged extends DimViviendaEvent {
  final List<LstFactorRiesgo> lstFactorRiesgo;

  const FactoresRiesgoViviendaChanged(this.lstFactorRiesgo);
}

class PresenciaAnimalesViviendaChanged extends DimViviendaEvent {
  final List<LstPresenciaAnimal> lstPresenciaAnimal;

  const PresenciaAnimalesViviendaChanged(this.lstPresenciaAnimal);
}
