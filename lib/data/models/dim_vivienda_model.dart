import 'dart:convert';

import '../../domain/entities/dim_vivienda_entity.dart';
import 'factor_riesgo_vivienda_model.dart';
import 'presencia_animal_vivienda_model.dart';
import 'servicio_publico_vivienda_model.dart';
import 'techo_vivienda_model.dart';
import 'tipo_combustible_vivienda_model.dart';
import 'tipo_sanitario_vivienda_model.dart';
import 'tratamiento_agua_vivienda_model.dart';

DimViviendaModel dimViviendaFromJson(String str) =>
    DimViviendaModel.fromJson(json.decode(str));

class DimViviendaModel extends DimViviendaEntity {
  DimViviendaModel({
    int? familiaId,
    int? tipoViviendaId,
    int? tenenciaViviendaId,
    int? ventilacionViviendaId,
    int? iluminacionViviendaId,
    int? pisoViviendaId,
    String? otroTipoPiso,
    List<LstTecho>? lstTechos,
    List<LstServPublico>? lstServPublicos,
    List<LstTmtoAgua>? lstTmtoAguas,
    List<LstFactoresRiesgo>? lstFactoresRiesgo,
    List<LstTiposSanitario>? lstTiposSanitario,
    List<LstTiposCombustible>? lstTiposCombustible,
    List<LstPresenciaAnimal>? lstPresenciaAnimales,
  }) : super(
          familiaId: familiaId,
          tipoViviendaId: tipoViviendaId,
          tenenciaViviendaId: tenenciaViviendaId,
          ventilacionViviendaId: ventilacionViviendaId,
          iluminacionViviendaId: iluminacionViviendaId,
          pisoViviendaId: pisoViviendaId,
          otroTipoPiso: otroTipoPiso,
          lstTechos: lstTechos,
          lstServPublicos: lstServPublicos,
          lstTmtoAguas: lstTmtoAguas,
          lstFactoresRiesgo: lstFactoresRiesgo,
          lstTiposSanitario: lstTiposSanitario,
          lstTiposCombustible: lstTiposCombustible,
          lstPresenciaAnimales: lstPresenciaAnimales,
        );

  factory DimViviendaModel.fromJson(Map<String, dynamic> json) =>
      DimViviendaModel(
        familiaId: json["Familia_id"],
        tipoViviendaId: json["TipoVivienda_id"],
        tenenciaViviendaId: json["TenenciaVivienda_id"],
        ventilacionViviendaId: json["VentilacionVivienda_id"],
        iluminacionViviendaId: json["IluminacionVivienda_id"],
        pisoViviendaId: json["PisoVivienda_id"],
        otroTipoPiso: json["OtroTipoPiso"],
        lstTechos: json["lstTechos"] == null
            ? []
            : List<LstTecho>.from(
                json["lstTechos"]!.map((x) => LstTecho.fromJson(x))),
        lstServPublicos: json["lstServPublicos"] == null
            ? []
            : List<LstServPublico>.from(json["lstServPublicos"]!
                .map((x) => LstServPublico.fromJson(x))),
        lstTmtoAguas: json["lstTmtoAguas"] == null
            ? []
            : List<LstTmtoAgua>.from(
                json["lstTmtoAguas"]!.map((x) => LstTmtoAgua.fromJson(x))),
        lstFactoresRiesgo: json["lstFactoresRiesgo"] == null
            ? []
            : List<LstFactoresRiesgo>.from(json["lstFactoresRiesgo"]!
                .map((x) => LstFactoresRiesgo.fromJson(x))),
        lstTiposSanitario: json["lstTiposSanitario"] == null
            ? []
            : List<LstTiposSanitario>.from(json["lstTiposSanitario"]!
                .map((x) => LstTiposSanitario.fromJson(x))),
        lstTiposCombustible: json["lstTiposCombustible"] == null
            ? []
            : List<LstTiposCombustible>.from(json["lstTiposCombustible"]!
                .map((x) => LstTiposCombustible.fromJson(x))),
        lstPresenciaAnimales: json["lstPresenciaAnimales"] == null
            ? []
            : List<LstPresenciaAnimal>.from(json["lstPresenciaAnimales"]!
                .map((x) => LstPresenciaAnimal.fromJson(x))),
      );
}
