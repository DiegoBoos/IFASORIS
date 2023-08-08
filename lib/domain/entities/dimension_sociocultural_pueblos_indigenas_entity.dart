import '../../data/models/evento_costumbre_participa_model.dart';
import '../../ui/blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart';

class DimensionSocioCulturalPueblosIndigenasEntity {
  DimensionSocioCulturalPueblosIndigenasEntity({
    this.dimSocioCulturalPueblosIndigenasId,
    this.familiaId,
    this.afiliadoId,
    this.religionProfesaId,
    this.conoceUsosCostumbresId,
    this.cualesUsosCostumbres,
    this.participaCostumbresId,
    this.costumbrePracticaId,
    this.sancionJusticiaId,
    this.sitiosSagradosId,
    this.cualesSitiosSagrados,
    this.lstEventoCostumbreParticipa,
    this.formStatus = const DimensionSocioCulturalPueblosIndigenasFormInitial(),
  });

  int? dimSocioCulturalPueblosIndigenasId;
  int? familiaId;
  int? afiliadoId;
  int? religionProfesaId;
  int? conoceUsosCostumbresId;
  String? cualesUsosCostumbres;
  int? participaCostumbresId;
  int? costumbrePracticaId;
  int? sancionJusticiaId;
  int? sitiosSagradosId;
  String? cualesSitiosSagrados;
  List<LstEventoCostumbreParticipa>? lstEventoCostumbreParticipa;
  DimensionSocioCulturalPueblosIndigenasState formStatus;

  DimensionSocioCulturalPueblosIndigenasEntity copyWith({
    int? dimSocioCulturalPueblosIndigenasId,
    int? familiaId,
    int? afiliadoId,
    int? religionProfesaId,
    int? conoceUsosCostumbresId,
    String? cualesUsosCostumbres,
    int? participaCostumbresId,
    int? costumbrePracticaId,
    int? sancionJusticiaId,
    int? sitiosSagradosId,
    String? cualesSitiosSagrados,
    List<LstEventoCostumbreParticipa>? lstEventoCostumbreParticipa,
    DimensionSocioCulturalPueblosIndigenasState? formStatus,
  }) =>
      DimensionSocioCulturalPueblosIndigenasEntity(
        dimSocioCulturalPueblosIndigenasId:
            dimSocioCulturalPueblosIndigenasId ??
                this.dimSocioCulturalPueblosIndigenasId,
        familiaId: familiaId ?? this.familiaId,
        afiliadoId: afiliadoId ?? this.afiliadoId,
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
            lstEventoCostumbreParticipa ?? this.lstEventoCostumbreParticipa,
        formStatus: formStatus ?? this.formStatus,
      );

  Map<String, dynamic> toJson() => {
        "DimSocioCulturalPueblosIndigenas_id":
            dimSocioCulturalPueblosIndigenasId,
        "Familia_id": familiaId,
        "Afiliado_id": afiliadoId,
        "ReligionProfesa_id": religionProfesaId,
        "ConoceUsosCostumbres_id": conoceUsosCostumbresId,
        "Cuales_UsosCostumbres": cualesUsosCostumbres,
        "ParticipaCostumbres_id": participaCostumbresId,
        "CostumbrePractica_id": costumbrePracticaId,
        "SancionJusticia_id": sancionJusticiaId,
        "SitiosSagrados_id": sitiosSagradosId,
        "Cuales_SitiosSagrados": cualesSitiosSagrados
      };
}
