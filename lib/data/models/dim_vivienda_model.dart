import 'dart:convert';

import '../../domain/entities/dim_vivienda_entity.dart';

DimViviendaModel dimViviendaFromJson(String str) =>
    DimViviendaModel.fromDB(json.decode(str));

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
    String? otroPresenciaAnimal,
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
          otroPresenciaAnimal: otroPresenciaAnimal ?? '',
        );

  factory DimViviendaModel.fromDB(Map<String, dynamic> json) =>
      DimViviendaModel(
        datoViviendaId: json["DatoVivienda_id"],
        familiaId: json["Familia_id"],
        tipoViviendaId: json["TipoVivienda_id"],
        tenenciaViviendaId: json["TenenciaVivienda_id"],
        pisosViviendaIds: json["PisosVivienda_ids"] != "null"
            ? List<int>.from(jsonDecode(json["PisosVivienda_ids"]))
            : [],
        otroTipoPiso: json["OtroTipoPiso"],
        techosViviendaIds: json["TechoVivienda_id"],
        otroTipoTecho: json["OtroTipoTecho"],
        ventilacionViviendaId: json["VentilacionVivienda_id"],
        iluminacionViviendaId: json["IluminacionVivienda_id"],
        serviciosPublicosViviendaIds: json["ServiciosPublicosVivienda_ids"] !=
                "null"
            ? List<int>.from(jsonDecode(json["ServiciosPublicosVivienda_ids"]))
            : [],
        tratamientosAguaViviendaIds: json["TratamientosAguaVivienda_ids"] !=
                "null"
            ? List<int>.from(jsonDecode(json["TratamientosAguaVivienda_ids"]))
            : [],
        tiposSanitarioViviendaIds: json["TiposSanitarioVivienda_ids"] != "null"
            ? List<int>.from(jsonDecode(json["TiposSanitarioVivienda_ids"]))
            : [],
        otroTipoSanitario: json["OtroTipoSanitario"],
        tiposCombustibleViviendaIds: json["TiposCombustibleVivienda_ids"] !=
                "null"
            ? List<int>.from(jsonDecode(json["TiposCombustibleVivienda_ids"]))
            : [],
        otroTipoCombustible: json["OtroTipoCombustible"],
        factoresRiesgoViviendaIds: json["FactoresRiesgoVivienda_ids"] != "null"
            ? List<int>.from(jsonDecode(json["FactoresRiesgoVivienda_ids"]))
            : [],
        presenciaAnimalesViviendaIds: json["PresenciaAnimalesVivienda_ids"] !=
                "null"
            ? List<int>.from(jsonDecode(json["PresenciaAnimalesVivienda_ids"]))
            : [],
        otroPresenciaAnimal: json["OtroPresenciaAnimal"],
      );
}
