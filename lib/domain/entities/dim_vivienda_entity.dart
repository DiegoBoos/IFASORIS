import '../../ui/blocs/dim_vivienda/dim_vivienda_bloc.dart';

class DimViviendaEntity {
  int? datoViviendaId;
  int? familiaId;
  int? tipoViviendaId;
  int? tenenciaViviendaId;
  int? pisoViviendaId;
  String? otroTipoPiso;
  int? techoViviendaId;
  String? otroTipoTecho;
  int? ventilacionViviendaId;
  int? iluminacionViviendaId;
  int? servicioPublicoViviendaId;
  int? tratamientoAguaViviendaId;
  int? tipoSanitarioViviendaId;
  String? otroTipoSanitario;
  int? tipoCombustibleViviendaId;
  String? otroTipoCombustible;
  int? factorRiesgoViviendaId;
  int? presenciaAnimalViviendaId;
  int? otroPresenciaAnimal;
  DimViviendaState formStatus;

  DimViviendaEntity(
      {this.datoViviendaId,
      this.familiaId,
      this.tipoViviendaId,
      this.tenenciaViviendaId,
      this.pisoViviendaId,
      this.otroTipoPiso,
      this.techoViviendaId,
      this.otroTipoTecho,
      this.ventilacionViviendaId,
      this.iluminacionViviendaId,
      this.servicioPublicoViviendaId,
      this.tratamientoAguaViviendaId,
      this.tipoSanitarioViviendaId,
      this.otroTipoSanitario,
      this.tipoCombustibleViviendaId,
      this.otroTipoCombustible,
      this.factorRiesgoViviendaId,
      this.presenciaAnimalViviendaId,
      this.otroPresenciaAnimal,
      this.formStatus = const FormInitial()});

  DimViviendaEntity copyWith(
          {int? datoViviendaId,
          int? familiaId,
          int? tipoViviendaId,
          int? tenenciaViviendaId,
          int? pisoViviendaId,
          String? otroTipoPiso,
          int? techoViviendaId,
          String? otroTipoTecho,
          int? ventilacionViviendaId,
          int? iluminacionViviendaId,
          int? servicioPublicoViviendaId,
          int? tratamientoAguaViviendaId,
          int? tipoSanitarioViviendaId,
          String? otroTipoSanitario,
          int? tipoCombustibleViviendaId,
          String? otroTipoCombustible,
          int? factorRiesgoViviendaId,
          int? presenciaAnimalViviendaId,
          int? otroPresenciaAnimal,
          DimViviendaState? formStatus}) =>
      DimViviendaEntity(
        datoViviendaId: datoViviendaId ?? this.datoViviendaId,
        familiaId: familiaId ?? this.familiaId,
        tipoViviendaId: tipoViviendaId ?? this.tipoViviendaId,
        tenenciaViviendaId: tenenciaViviendaId ?? this.tenenciaViviendaId,
        pisoViviendaId: pisoViviendaId ?? this.pisoViviendaId,
        otroTipoPiso: otroTipoPiso ?? this.otroTipoPiso,
        techoViviendaId: techoViviendaId ?? this.techoViviendaId,
        otroTipoTecho: otroTipoTecho ?? this.otroTipoTecho,
        ventilacionViviendaId:
            ventilacionViviendaId ?? this.ventilacionViviendaId,
        iluminacionViviendaId:
            iluminacionViviendaId ?? this.iluminacionViviendaId,
        servicioPublicoViviendaId:
            servicioPublicoViviendaId ?? this.servicioPublicoViviendaId,
        tratamientoAguaViviendaId:
            tratamientoAguaViviendaId ?? this.tratamientoAguaViviendaId,
        tipoSanitarioViviendaId:
            tipoSanitarioViviendaId ?? this.tipoSanitarioViviendaId,
        otroTipoSanitario: otroTipoSanitario ?? this.otroTipoSanitario,
        tipoCombustibleViviendaId:
            tipoCombustibleViviendaId ?? this.tipoCombustibleViviendaId,
        otroTipoCombustible: otroTipoCombustible ?? this.otroTipoCombustible,
        factorRiesgoViviendaId:
            factorRiesgoViviendaId ?? this.factorRiesgoViviendaId,
        presenciaAnimalViviendaId:
            presenciaAnimalViviendaId ?? this.presenciaAnimalViviendaId,
        otroPresenciaAnimal: otroPresenciaAnimal ?? this.otroPresenciaAnimal,
        formStatus: formStatus ?? this.formStatus,
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "Familia_id": familiaId,
        "TipoVivienda_id": tipoViviendaId,
        "TenenciaVivienda_id": tenenciaViviendaId,
        "PisoVivienda_id": pisoViviendaId,
        "OtroTipoPiso": otroTipoPiso,
        "TechoVivienda_id": techoViviendaId,
        "OtroTipoTecho": otroTipoTecho,
        "VentilacionVivienda_id": ventilacionViviendaId,
        "IluminacionVivienda_id": iluminacionViviendaId,
        "ServicioPublicoVivienda_id": servicioPublicoViviendaId,
        "TratamientoAguaVivienda_id": tratamientoAguaViviendaId,
        "TipoSanitarioVivienda_id": tipoSanitarioViviendaId,
        "OtroTipoSanitario": otroTipoSanitario,
        "TipoCombustibleVivienda_id": tipoCombustibleViviendaId,
        "OtroTipoCombustible": otroTipoCombustible,
        "FactorRiesgoVivienda_id": factorRiesgoViviendaId,
        "PresenciaAnimalVivienda_id": presenciaAnimalViviendaId,
        "OtroPresenciaAnimal": otroPresenciaAnimal,
      };
}
