import 'dart:convert';

import '../../domain/entities/dim_vivienda.dart';
import 'factor_riesgo_vivienda.dart';
import 'piso_vivienda.dart';
import 'presencia_animal_vivienda.dart';
import 'servicio_publico_vivienda.dart';
import 'techo_vivienda.dart';
import 'tipo_combustible_vivienda.dart';
import 'tipo_sanitario_vivienda.dart';
import 'tratamiento_agua_vivienda.dart';

DimViviendaModel dimViviendaFromJson(String str) =>
    DimViviendaModel.fromJson(json.decode(str));

class DimViviendaModel extends DimViviendaEntity {
  const DimViviendaModel({
    super.datoViviendaId,
    super.afiliadoId,
    super.familiaId,
    super.tipoViviendaId,
    super.tenenciaViviendaId,
    super.ventilacionViviendaId,
    super.iluminacionViviendaId,
    super.cuartosViviendaId,
    super.lstPiso,
    super.lstTecho,
    super.lstServPublico,
    super.lstTmtoAgua,
    super.lstFactorRiesgo,
    super.lstTipoSanitario,
    super.lstTipoCombustible,
    super.lstPresenciaAnimal,
  });

  factory DimViviendaModel.fromEntity(DimViviendaEntity entity) {
    return DimViviendaModel(
      datoViviendaId: entity.datoViviendaId,
      afiliadoId: entity.afiliadoId,
      familiaId: entity.familiaId,
      tipoViviendaId: entity.tipoViviendaId,
      tenenciaViviendaId: entity.tenenciaViviendaId,
      ventilacionViviendaId: entity.ventilacionViviendaId,
      iluminacionViviendaId: entity.iluminacionViviendaId,
      cuartosViviendaId: entity.cuartosViviendaId,
      lstPiso: entity.lstPiso,
      lstTecho: entity.lstTecho,
      lstServPublico: entity.lstServPublico,
      lstTmtoAgua: entity.lstTmtoAgua,
      lstFactorRiesgo: entity.lstFactorRiesgo,
      lstTipoSanitario: entity.lstTipoSanitario,
      lstTipoCombustible: entity.lstTipoCombustible,
      lstPresenciaAnimal: entity.lstPresenciaAnimal,
    );
  }

  factory DimViviendaModel.fromJson(Map<String, dynamic> json) =>
      DimViviendaModel(
        datoViviendaId: json["DatoVivienda_id"],
        afiliadoId: json["Afiliado_id"],
        familiaId: json["Familia_id"],
        tipoViviendaId: json["TipoVivienda_id"],
        tenenciaViviendaId: json["TenenciaVivienda_id"],
        ventilacionViviendaId: json["VentilacionVivienda_id"],
        iluminacionViviendaId: json["IluminacionVivienda_id"],
        cuartosViviendaId: json["CuartosVivienda_id"],
        lstPiso: json["LstPiso"] == null
            ? []
            : List<LstPiso>.from(
                json["LstPiso"]!.map((x) => LstPiso.fromJson(x))),
        lstTecho: json["lstTecho"] == null
            ? []
            : List<LstTecho>.from(
                json["lstTecho"]!.map((x) => LstTecho.fromJson(x))),
        lstServPublico: json["lstServPublico"] == null
            ? []
            : List<LstServPublico>.from(
                json["lstServPublico"]!.map((x) => LstServPublico.fromJson(x))),
        lstTmtoAgua: json["lstTmtoAgua"] == null
            ? []
            : List<LstTmtoAgua>.from(
                json["lstTmtoAgua"]!.map((x) => LstTmtoAgua.fromJson(x))),
        lstFactorRiesgo: json["lstFactorRiesgo"] == null
            ? []
            : List<LstFactorRiesgo>.from(json["lstFactorRiesgo"]!
                .map((x) => LstFactorRiesgo.fromJson(x))),
        lstTipoSanitario: json["lstTipoSanitario"] == null
            ? []
            : List<LstTipoSanitario>.from(json["lstTipoSanitario"]!
                .map((x) => LstTipoSanitario.fromJson(x))),
        lstTipoCombustible: json["lstTipoCombustible"] == null
            ? []
            : List<LstTipoCombustible>.from(json["lstTipoCombustible"]!
                .map((x) => LstTipoCombustible.fromJson(x))),
        lstPresenciaAnimal: json["lstPresenciaAnimal"] == null
            ? []
            : List<LstPresenciaAnimal>.from(json["lstPresenciaAnimal"]!
                .map((x) => LstPresenciaAnimal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "Afiliado_id": afiliadoId,
        "Familia_id": familiaId,
        "TipoVivienda_id": tipoViviendaId,
        "TenenciaVivienda_id": tenenciaViviendaId,
        "VentilacionVivienda_id": ventilacionViviendaId,
        "IluminacionVivienda_id": iluminacionViviendaId,
        "NroCuartosVivienda_id": cuartosViviendaId,
      };
}
