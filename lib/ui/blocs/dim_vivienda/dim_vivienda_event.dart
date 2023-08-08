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

class PisoViviendaChanged extends DimViviendaEvent {
  final int pisoViviendaId;

  const PisoViviendaChanged(this.pisoViviendaId);
}

class OtroTipoPisoChanged extends DimViviendaEvent {
  final String otroTipoPiso;

  const OtroTipoPisoChanged(this.otroTipoPiso);
}

class TechosViviendaChanged extends DimViviendaEvent {
  final List<LstTecho> lstTechos;

  const TechosViviendaChanged(this.lstTechos);
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

class GetPresenciaAnimales extends DimViviendaEvent {
  final int? datoViviendaId;

  const GetPresenciaAnimales(this.datoViviendaId);
}

class ServiciosPublicosViviendaChanged extends DimViviendaEvent {
  final List<LstServPublico> lstServPublicos;

  const ServiciosPublicosViviendaChanged(this.lstServPublicos);
}

class TratamientosAguaViviendaChanged extends DimViviendaEvent {
  final List<LstTmtoAgua> lstTmtoAguas;

  const TratamientosAguaViviendaChanged(this.lstTmtoAguas);
}

class TiposSanitarioViviendaChanged extends DimViviendaEvent {
  final List<LstTiposSanitario> lstTiposSanitario;

  const TiposSanitarioViviendaChanged(this.lstTiposSanitario);
}

class TiposCombustibleViviendaChanged extends DimViviendaEvent {
  final List<LstTiposCombustible> lstTiposCombustible;

  const TiposCombustibleViviendaChanged(this.lstTiposCombustible);
}

class FactoresRiesgoViviendaChanged extends DimViviendaEvent {
  final List<LstFactoresRiesgo> lstFactoresRiesgo;

  const FactoresRiesgoViviendaChanged(this.lstFactoresRiesgo);
}

class PresenciaAnimalesViviendaChanged extends DimViviendaEvent {
  final List<LstPresenciaAnimal> lstPresenciaAnimales;

  const PresenciaAnimalesViviendaChanged(this.lstPresenciaAnimales);
}
