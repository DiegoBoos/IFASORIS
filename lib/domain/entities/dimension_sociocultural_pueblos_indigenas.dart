import 'package:equatable/equatable.dart';

import '../../data/models/evento_costumbre_participa.dart';
import '../../ui/blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart';

class DimensionSocioCulturalPueblosIndigenasEntity extends Equatable {
  final int? dimSocioCulturalPueblosIndigenasId;
  final int? familiaId;
  final int? afiliadoId;
  final int? religionProfesaId;
  final int? conoceUsosCostumbresId;
  final String? cualesUsosCostumbres;
  final int? participaCostumbresId;
  final int? costumbrePracticaId;
  final int? sancionJusticiaId;
  final int? sitiosSagradosId;
  final String? cualesSitiosSagrados;
  final List<LstEventoCostumbreParticipa>? lstEventoCostumbreParticipa;
  final DimensionSocioCulturalPueblosIndigenasState formStatus;

  const DimensionSocioCulturalPueblosIndigenasEntity({
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

  @override
  List<Object?> get props => [
        dimSocioCulturalPueblosIndigenasId,
        familiaId,
        afiliadoId,
        religionProfesaId,
        conoceUsosCostumbresId,
        cualesUsosCostumbres,
        participaCostumbresId,
        costumbrePracticaId,
        sancionJusticiaId,
        sitiosSagradosId,
        cualesSitiosSagrados,
        lstEventoCostumbreParticipa,
        formStatus
      ];
}
