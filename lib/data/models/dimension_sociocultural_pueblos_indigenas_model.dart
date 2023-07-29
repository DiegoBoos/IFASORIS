import 'dart:convert';

import '../../domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';

DimensionSocioculturalPueblosIndigenasModel
    dimensionSocioculturalPueblosIndigenasFromJson(String str) =>
        DimensionSocioculturalPueblosIndigenasModel.fromJson(json.decode(str));

class DimensionSocioculturalPueblosIndigenasModel
    extends DimensionSocioculturalPueblosIndigenasEntity {
  DimensionSocioculturalPueblosIndigenasModel({
    int? dimensionSocioculturalPueblosIndigenasId,
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
  }) : super(
          dimensionSocioculturalPueblosIndigenasId:
              dimensionSocioculturalPueblosIndigenasId,
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
        );

  factory DimensionSocioculturalPueblosIndigenasModel.fromJson(
          Map<String, dynamic> json) =>
      DimensionSocioculturalPueblosIndigenasModel(
        dimensionSocioculturalPueblosIndigenasId:
            json["DimensionSocioculturalPuebloIndigena_id"],
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
      );
}
