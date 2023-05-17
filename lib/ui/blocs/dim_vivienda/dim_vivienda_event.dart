part of 'dim_vivienda_bloc.dart';

abstract class DimViviendaEvent extends Equatable {
  const DimViviendaEvent();

  @override
  List<Object> get props => [];
}

class DimViviendaInit extends DimViviendaEvent {}

class DimViviendaReset extends DimViviendaEvent {}

class DimViviendaSubmitted extends DimViviendaEvent {}

class GetDimVivienda extends DimViviendaEvent {
  final int familiaId;

  const GetDimVivienda(this.familiaId);
}

class DatoViviendaChanged extends DimViviendaEvent {
  final int datoViviendaId;

  const DatoViviendaChanged(this.datoViviendaId);
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

class PisosViviendaChanged extends DimViviendaEvent {
  final List<int> pisosViviendaIds;

  const PisosViviendaChanged(this.pisosViviendaIds);
}

class OtroTipoPisoChanged extends DimViviendaEvent {
  final String otroTipoPiso;

  const OtroTipoPisoChanged(this.otroTipoPiso);
}

class TechosViviendaChanged extends DimViviendaEvent {
  final List<int> techosViviendaIds;

  const TechosViviendaChanged(this.techosViviendaIds);
}

class OtroTipoTechoChanged extends DimViviendaEvent {
  final String otroTipoTecho;

  const OtroTipoTechoChanged(this.otroTipoTecho);
}

class VentilacionViviendaChanged extends DimViviendaEvent {
  final int ventilacionViviendaId;

  const VentilacionViviendaChanged(this.ventilacionViviendaId);
}

class IluminacionViviendaChanged extends DimViviendaEvent {
  final int iluminacionViviendaId;

  const IluminacionViviendaChanged(this.iluminacionViviendaId);
}

class ServiciosPublicosViviendaChanged extends DimViviendaEvent {
  final List<int> serviciosPublicosViviendaIds;

  const ServiciosPublicosViviendaChanged(this.serviciosPublicosViviendaIds);
}

class TratamientoAguaViviendaChanged extends DimViviendaEvent {
  final List<int> tratamientosAguaViviendaIds;

  const TratamientoAguaViviendaChanged(this.tratamientosAguaViviendaIds);
}

class TiposSanitarioViviendaChanged extends DimViviendaEvent {
  final List<int> tiposSanitarioViviendaIds;

  const TiposSanitarioViviendaChanged(this.tiposSanitarioViviendaIds);
}

class OtroTipoSanitarioChanged extends DimViviendaEvent {
  final String otroTipoSanitario;

  const OtroTipoSanitarioChanged(this.otroTipoSanitario);
}

class TiposCombustibleViviendaChanged extends DimViviendaEvent {
  final List<int> tiposCombustibleViviendaIds;

  const TiposCombustibleViviendaChanged(this.tiposCombustibleViviendaIds);
}

class OtroTipoCombustibleChanged extends DimViviendaEvent {
  final String otroTipoCombustible;

  const OtroTipoCombustibleChanged(this.otroTipoCombustible);
}

class FactoresRiesgoViviendaChanged extends DimViviendaEvent {
  final List<int> factoresRiesgoViviendaIds;

  const FactoresRiesgoViviendaChanged(this.factoresRiesgoViviendaIds);
}

class PresenciaAnimalesViviendaChanged extends DimViviendaEvent {
  final List<int> presenciaAnimalesViviendaIds;

  const PresenciaAnimalesViviendaChanged(this.presenciaAnimalesViviendaIds);
}

class OtroPresenciaAnimalChanged extends DimViviendaEvent {
  final int otroPresenciaAnimal;

  const OtroPresenciaAnimalChanged(this.otroPresenciaAnimal);
}
