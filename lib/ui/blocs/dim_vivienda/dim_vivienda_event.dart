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

class FamiliaChanged extends DimViviendaEvent {
  final int familiaId;

  const FamiliaChanged(this.familiaId);
}

class TipoVivienda extends DimViviendaEvent {
  final int tipoViviendaId;

  const TipoVivienda(this.tipoViviendaId);
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

class TechoViviendaChanged extends DimViviendaEvent {
  final int techoViviendaId;

  const TechoViviendaChanged(this.techoViviendaId);
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

class ServicioPublicoViviendaChanged extends DimViviendaEvent {
  final int servicioPublicoViviendaId;

  const ServicioPublicoViviendaChanged(this.servicioPublicoViviendaId);
}

class TratamientoAguaViviendaChanged extends DimViviendaEvent {
  final int tratamientoAguaViviendaId;

  const TratamientoAguaViviendaChanged(this.tratamientoAguaViviendaId);
}

class TipoSanitarioViviendaChanged extends DimViviendaEvent {
  final int tipoSanitarioViviendaId;

  const TipoSanitarioViviendaChanged(this.tipoSanitarioViviendaId);
}

class OtroTipoSanitarioChanged extends DimViviendaEvent {
  final String otroTipoSanitario;

  const OtroTipoSanitarioChanged(this.otroTipoSanitario);
}

class TipoCombustibleViviendaChanged extends DimViviendaEvent {
  final int tipoCombustibleViviendaId;

  const TipoCombustibleViviendaChanged(this.tipoCombustibleViviendaId);
}

class OtroTipoCombustibleChanged extends DimViviendaEvent {
  final String otroTipoCombustible;

  const OtroTipoCombustibleChanged(this.otroTipoCombustible);
}

class FactorRiesgoViviendaChanged extends DimViviendaEvent {
  final int factorRiesgoViviendaId;

  const FactorRiesgoViviendaChanged(this.factorRiesgoViviendaId);
}

class PresenciaAnimalViviendaChanged extends DimViviendaEvent {
  final int presenciaAnimalViviendaId;

  const PresenciaAnimalViviendaChanged(this.presenciaAnimalViviendaId);
}

class OtroPresenciaAnimalChanged extends DimViviendaEvent {
  final int otroPresenciaAnimal;

  const OtroPresenciaAnimalChanged(this.otroPresenciaAnimal);
}
