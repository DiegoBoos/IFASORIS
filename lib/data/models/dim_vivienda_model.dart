import 'dart:convert';

import '../../domain/entities/dim_vivienda_entity.dart';

DimViviendaModel dimViviendaFromJson(String str) =>
    DimViviendaModel.fromJson(json.decode(str));

class DimViviendaModel extends DimViviendaEntity {
  DimViviendaModel({
    int? datoViviendaId,
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
  }) : super(
          datoViviendaId: datoViviendaId ?? 0,
          familiaId: familiaId ?? 0,
          tipoViviendaId: tipoViviendaId ?? 0,
          tenenciaViviendaId: tenenciaViviendaId ?? 0,
          pisoViviendaId: pisoViviendaId ?? 0,
          otroTipoPiso: otroTipoPiso ?? '',
          techoViviendaId: techoViviendaId ?? 0,
          otroTipoTecho: otroTipoTecho ?? '',
          ventilacionViviendaId: ventilacionViviendaId ?? 0,
          iluminacionViviendaId: iluminacionViviendaId ?? 0,
          servicioPublicoViviendaId: servicioPublicoViviendaId ?? 0,
          tratamientoAguaViviendaId: tratamientoAguaViviendaId ?? 0,
          tipoSanitarioViviendaId: tipoSanitarioViviendaId ?? 0,
          otroTipoSanitario: otroTipoSanitario ?? '',
          tipoCombustibleViviendaId: tipoCombustibleViviendaId ?? 0,
          otroTipoCombustible: otroTipoCombustible ?? '',
          factorRiesgoViviendaId: factorRiesgoViviendaId ?? 0,
          presenciaAnimalViviendaId: presenciaAnimalViviendaId ?? 0,
          otroPresenciaAnimal: otroPresenciaAnimal ?? 0,
        );

  factory DimViviendaModel.fromJson(Map<String, dynamic> json) =>
      DimViviendaModel(
        datoViviendaId: json["DatoVivienda_id"],
        familiaId: json["Familia_id"],
        tipoViviendaId: json["TipoVivienda_id"],
        tenenciaViviendaId: json["TenenciaVivienda_id"],
        pisoViviendaId: json["PisoVivienda_id"],
        otroTipoPiso: json["OtroTipoPiso"],
        techoViviendaId: json["TechoVivienda_id"],
        otroTipoTecho: json["OtroTipoTecho"],
        ventilacionViviendaId: json["VentilacionVivienda_id"],
        iluminacionViviendaId: json["IluminacionVivienda_id"],
        servicioPublicoViviendaId: json["ServicioPublicoVivienda_id"],
        tratamientoAguaViviendaId: json["TratamientoAguaVivienda_id"],
        tipoSanitarioViviendaId: json["TipoSanitarioVivienda_id"],
        otroTipoSanitario: json["OtroTipoSanitario"],
        tipoCombustibleViviendaId: json["TipoCombustibleVivienda_id"],
        otroTipoCombustible: json["OtroTipoCombustible"],
        factorRiesgoViviendaId: json["FactorRiesgoVivienda_id"],
        presenciaAnimalViviendaId: json["PresenciaAnimalVivienda_id"],
        otroPresenciaAnimal: json["OtroPresenciaAnimal"],
      );
}
