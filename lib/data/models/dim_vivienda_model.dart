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
    List<int>? pisosViviendaIds,
    String? otroTipoPiso,
    List<int>? techosViviendaIds,
    String? otroTipoTecho,
    int? ventilacionViviendaId,
    int? iluminacionViviendaId,
    List<int>? serviciosPublicosViviendaIds,
    List<int>? tratamientosAguaViviendaIds,
    List<int>? tiposSanitarioViviendaIds,
    String? otroTipoSanitario,
    List<int>? tiposCombustibleViviendaIds,
    String? otroTipoCombustible,
    List<int>? factoresRiesgoViviendaIds,
    List<int>? presenciaAnimalesViviendaIds,
    int? otroPresenciaAnimal,
  }) : super(
          datoViviendaId: datoViviendaId ?? 0,
          familiaId: familiaId ?? 0,
          tipoViviendaId: tipoViviendaId ?? 0,
          tenenciaViviendaId: tenenciaViviendaId ?? 0,
          pisosViviendaIds: pisosViviendaIds,
          otroTipoPiso: otroTipoPiso ?? '',
          techosViviendaIds: techosViviendaIds,
          otroTipoTecho: otroTipoTecho ?? '',
          ventilacionViviendaId: ventilacionViviendaId ?? 0,
          iluminacionViviendaId: iluminacionViviendaId ?? 0,
          serviciosPublicosViviendaIds: serviciosPublicosViviendaIds,
          tratamientosAguaViviendaIds: tratamientosAguaViviendaIds,
          tiposSanitarioViviendaIds: tiposSanitarioViviendaIds,
          otroTipoSanitario: otroTipoSanitario ?? '',
          tiposCombustibleViviendaIds: tiposCombustibleViviendaIds,
          otroTipoCombustible: otroTipoCombustible ?? '',
          factoresRiesgoViviendaIds: factoresRiesgoViviendaIds,
          presenciaAnimalesViviendaIds: presenciaAnimalesViviendaIds,
          otroPresenciaAnimal: otroPresenciaAnimal ?? 0,
        );

  factory DimViviendaModel.fromJson(Map<String, dynamic> json) =>
      DimViviendaModel(
        datoViviendaId: json["DatoVivienda_id"],
        familiaId: json["Familia_id"],
        tipoViviendaId: json["TipoVivienda_id"],
        tenenciaViviendaId: json["TenenciaVivienda_id"],
        pisosViviendaIds: json["PisoVivienda_id"],
        otroTipoPiso: json["OtroTipoPiso"],
        techosViviendaIds: json["TechoVivienda_id"],
        otroTipoTecho: json["OtroTipoTecho"],
        ventilacionViviendaId: json["VentilacionVivienda_id"],
        iluminacionViviendaId: json["IluminacionVivienda_id"],
        serviciosPublicosViviendaIds: json["ServicioPublicoVivienda_id"],
        tratamientosAguaViviendaIds: json["TratamientoAguaVivienda_id"],
        tiposSanitarioViviendaIds: json["TipoSanitarioVivienda_id"],
        otroTipoSanitario: json["OtroTipoSanitario"],
        tiposCombustibleViviendaIds: json["TipoCombustibleVivienda_id"],
        otroTipoCombustible: json["OtroTipoCombustible"],
        factoresRiesgoViviendaIds: json["FactorRiesgoVivienda_id"],
        presenciaAnimalesViviendaIds: json["PresenciaAnimalVivienda_id"],
        otroPresenciaAnimal: json["OtroPresenciaAnimal"],
      );
}
