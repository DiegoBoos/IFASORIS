import '../../data/models/evento_costumbre_participa_model.dart';
import '../../ui/blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart';

class DimensionSocioculturalPueblosIndigenasEntity {
  DimensionSocioculturalPueblosIndigenasEntity(
      {this.dimensionSocioculturalPueblosIndigenasId,
      this.afiliadoId,
      this.familiaId,
      this.religionProfesaId,
      this.conoceUsosCostumbresId,
      this.cualesUsosCostumbres,
      this.participaCostumbresId,
      this.costumbrePracticaId,
      this.sancionJusticiaId,
      this.sitiosSagradosId,
      this.cualesSitiosSagrados,
      this.lstEventoCostumbreParticipa,
      this.formStatus =
          const DimensionSocioculturalPueblosIndigenasFormInitial(),
      this.remoteDimensionSocioculturalPuebloIndigena});

  int? dimensionSocioculturalPueblosIndigenasId;
  int? afiliadoId;
  int? familiaId;
  int? religionProfesaId;
  int? conoceUsosCostumbresId;
  String? cualesUsosCostumbres;
  int? participaCostumbresId;
  int? costumbrePracticaId;
  int? sancionJusticiaId;
  int? sitiosSagradosId;
  String? cualesSitiosSagrados;
  List<LstEventoCostumbreParticipa>? lstEventoCostumbreParticipa;
  DimensionSocioculturalPueblosIndigenasState formStatus;
  int? remoteDimensionSocioculturalPuebloIndigena;

  DimensionSocioculturalPueblosIndigenasEntity copyWith({
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
    List<LstEventoCostumbreParticipa>? lstEventoCostumbreParticipa,
    DimensionSocioculturalPueblosIndigenasState? formStatus,
  }) =>
      DimensionSocioculturalPueblosIndigenasEntity(
        dimensionSocioculturalPueblosIndigenasId:
            dimensionSocioculturalPueblosIndigenasId ??
                this.dimensionSocioculturalPueblosIndigenasId,
        afiliadoId: afiliadoId ?? this.afiliadoId,
        familiaId: familiaId ?? this.familiaId,
        religionProfesaId: religionProfesaId ?? this.religionProfesaId,
        conoceUsosCostumbresId:
            conoceUsosCostumbresId ?? this.conoceUsosCostumbresId,
        cualesUsosCostumbres: cualesUsosCostumbres ?? this.cualesUsosCostumbres,
        participaCostumbresId:
            participaCostumbresId ?? this.participaCostumbresId,
        costumbrePracticaId: costumbrePracticaId ?? this.costumbrePracticaId,
        sancionJusticiaId: sancionJusticiaId ?? this.sancionJusticiaId,
        sitiosSagradosId: sitiosSagradosId ?? this.sitiosSagradosId,
        cualesSitiosSagrados: cualesSitiosSagrados ?? this.cualesSitiosSagrados,
        lstEventoCostumbreParticipa:
            lstEventoCostumbreParticipa ?? lstEventoCostumbreParticipa,
        formStatus: formStatus ?? this.formStatus,
      );

  Map<String, dynamic> toJson() => {
        "DimensionSocioculturalPuebloIndigena_id":
            dimensionSocioculturalPueblosIndigenasId,
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
        "remoteDimensionSocioculturalPuebloIndigena_id":
            remoteDimensionSocioculturalPuebloIndigena,
      };
}
