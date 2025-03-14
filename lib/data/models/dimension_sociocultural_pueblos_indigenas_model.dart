import 'dart:convert';

import 'package:ifasoris/data/models/evento_costumbre_participa_model.dart';

import '../../domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';

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
  DimensionSocioCulturalPueblosIndigenasModel({
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
  }) : super(
          dimSocioCulturalPueblosIndigenasId:
              dimSocioCulturalPueblosIndigenasId,
          afiliadoId: afiliadoId,
          familiaId: familiaId,
          religionProfesaId: religionProfesaId,
          conoceUsosCostumbresId: conoceUsosCostumbresId,
          cualesUsosCostumbres: cualesUsosCostumbres,
          participaCostumbresId: participaCostumbresId,
          costumbrePracticaId: costumbrePracticaId,
          sancionJusticiaId: sancionJusticiaId,
          sitiosSagradosId: sitiosSagradosId,
          cualesSitiosSagrados: cualesSitiosSagrados,
          lstEventoCostumbreParticipa: lstEventoCostumbreParticipa,
        );

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
}
