import 'dart:convert';

import 'package:ifasoris/data/models/evento_costumbre_participa.dart';

import '../../domain/entities/dimension_sociocultural_pueblos_indigenas.dart';

List<DimensionSocioCulturalPueblosIndigenasModel>
    listDimensionSocioCulturalPueblosIndigenasFromJson(String str) =>
        List<DimensionSocioCulturalPueblosIndigenasModel>.from(json
            .decode(str)
            .map((x) =>
                DimensionSocioCulturalPueblosIndigenasModel.fromJson(x)));

DimensionSocioCulturalPueblosIndigenasModel
    dimensionSocioCulturalPueblosIndigenasFromJson(String str) =>
        DimensionSocioCulturalPueblosIndigenasModel.fromJson(json.decode(str));

class DimensionSocioCulturalPueblosIndigenasModel
    extends DimensionSocioCulturalPueblosIndigenasEntity {
  const DimensionSocioCulturalPueblosIndigenasModel({
    int? dimSocioCulturalPueblosIndigenasId,
    int? afiliadoId,
    int? familiaId,
    int? religionProfesaId,
    int? conoceUsosCostumbresId,
    String? cualesUsosCostumbres,
    int? participaCostumbresId,
    int? costumbrePracticaId,
    int? sancionJusticiaId,
    int? sitiosSagradosId,
    String? cualesSitiosSagrados,
    List<LstEventoCostumbreParticipa>? lstEventoCostumbreParticipa,
  });

  static DimensionSocioCulturalPueblosIndigenasModel fromEntity(
      DimensionSocioCulturalPueblosIndigenasEntity entity) {
    return DimensionSocioCulturalPueblosIndigenasModel(
      dimSocioCulturalPueblosIndigenasId:
          entity.dimSocioCulturalPueblosIndigenasId,
      afiliadoId: entity.afiliadoId,
      familiaId: entity.familiaId,
      religionProfesaId: entity.religionProfesaId,
      conoceUsosCostumbresId: entity.conoceUsosCostumbresId,
      cualesUsosCostumbres: entity.cualesUsosCostumbres,
      participaCostumbresId: entity.participaCostumbresId,
      costumbrePracticaId: entity.costumbrePracticaId,
      sancionJusticiaId: entity.sancionJusticiaId,
      sitiosSagradosId: entity.sitiosSagradosId,
      cualesSitiosSagrados: entity.cualesSitiosSagrados,
      lstEventoCostumbreParticipa: entity.lstEventoCostumbreParticipa,
    );
  }

  factory DimensionSocioCulturalPueblosIndigenasModel.fromJson(
          Map<String, dynamic> json) =>
      DimensionSocioCulturalPueblosIndigenasModel(
        dimSocioCulturalPueblosIndigenasId:
            json["DimSocioCulturalPueblosIndigenas_id"],
        afiliadoId: json["Afiliado_id"],
        familiaId: json["Familia_id"],
        religionProfesaId: json["ReligionProfesa_id"],
        conoceUsosCostumbresId: json["ConoceUsosCostumbres_id"],
        cualesUsosCostumbres: json["Cuales_UsosCostumbres"],
        participaCostumbresId: json["ParticipaCostumbres_id"],
        costumbrePracticaId: json["CostumbrePractica_id"],
        sancionJusticiaId: json["SancionJusticia_id"],
        sitiosSagradosId: json["SitiosSagrados_id"],
        cualesSitiosSagrados: json["Cuales_SitiosSagrados"],
        lstEventoCostumbreParticipa:
            json["LstEventosCostumbresParticipa"] != null
                ? listEventoCostumbreParticipaFromJson(
                    jsonEncode(json["LstEventosCostumbresParticipa"]))
                : null,
      );

  Map<String, dynamic> toJson() => {
        "DimSocioCulturalPueblosIndigenas_id":
            dimSocioCulturalPueblosIndigenasId,
        "Afiliado_id": afiliadoId,
        "Familia_id": familiaId,
        "ReligionProfesa_id": religionProfesaId,
        "ConoceUsosCostumbres_id": conoceUsosCostumbresId,
        "Cuales_UsosCostumbres": cualesUsosCostumbres,
        "ParticipaCostumbres_id": participaCostumbresId,
        "CostumbrePractica_id": costumbrePracticaId,
        "SancionJusticia_id": sancionJusticiaId,
        "SitiosSagrados_id": sitiosSagradosId,
        "Cuales_SitiosSagrados": cualesSitiosSagrados,
        "LstEventosCostumbresParticipa": lstEventoCostumbreParticipa,
      };
}
