import 'package:equatable/equatable.dart';

import '../../data/models/enfermedad_tradicional.dart';
import '../../data/models/especialidad_med_tradicional.dart';
import '../../data/models/lugar_atencion_medico.dart';
import '../../data/models/planta_medicinal.dart';
import '../../ui/blocs/atencion_salud/atencion_salud_bloc.dart';

class AtencionSaludEntity extends Equatable {
  final int? atencionSaludId;
  final int? afiliadoId;
  final int? familiaId;
  final int? enfermedadAcudeId;
  final int? recibioAtencionMedTradicionalId;
  final int? enfermedadTratamientoId;
  final int? utilizaPlantasMedId;
  final int? lugarPlantaMedicinalId;
  final List<LstEnfermedadTradicional>? lstEnfermedadesTradicionales;
  final List<LstEspMedTradicional>? lstEspecialidadesMedTradicional;
  final List<LstLugarAtencionMedico>? lstLugaresAtencionMedico;
  final List<LstPlantaMedicinal>? lstPlantasMedicinales;
  final AtencionSaludState formStatus;

  const AtencionSaludEntity({
    this.atencionSaludId,
    this.afiliadoId,
    this.familiaId,
    this.enfermedadAcudeId,
    this.recibioAtencionMedTradicionalId,
    this.enfermedadTratamientoId,
    this.utilizaPlantasMedId,
    this.lugarPlantaMedicinalId,
    this.lstEnfermedadesTradicionales,
    this.lstEspecialidadesMedTradicional,
    this.lstLugaresAtencionMedico,
    this.lstPlantasMedicinales,
    this.formStatus = const AtencionSaludFormInitial(),
  });

  AtencionSaludEntity copyWith({
    int? atencionSaludId,
    int? afiliadoId,
    int? familiaId,
    int? enfermedadAcudeId,
    int? recibioAtencionMedTradicionalId,
    int? enfermedadTratamientoId,
    int? utilizaPlantasMedId,
    int? lugarPlantaMedicinalId,
    List<LstEnfermedadTradicional>? lstEnfermedadesTradicionales,
    List<LstEspMedTradicional>? lstEspecialidadesMedTradicional,
    List<LstLugarAtencionMedico>? lstLugaresAtencionMedico,
    List<LstPlantaMedicinal>? lstPlantasMedicinales,
    AtencionSaludState? formStatus,
  }) =>
      AtencionSaludEntity(
        atencionSaludId: atencionSaludId ?? this.atencionSaludId,
        afiliadoId: afiliadoId ?? this.afiliadoId,
        familiaId: familiaId ?? this.familiaId,
        enfermedadAcudeId: enfermedadAcudeId ?? this.enfermedadAcudeId,
        recibioAtencionMedTradicionalId: recibioAtencionMedTradicionalId ??
            this.recibioAtencionMedTradicionalId,
        enfermedadTratamientoId:
            enfermedadTratamientoId ?? this.enfermedadTratamientoId,
        utilizaPlantasMedId: utilizaPlantasMedId ?? this.utilizaPlantasMedId,
        lugarPlantaMedicinalId:
            lugarPlantaMedicinalId ?? this.lugarPlantaMedicinalId,
        lstEnfermedadesTradicionales:
            lstEnfermedadesTradicionales ?? this.lstEnfermedadesTradicionales,
        lstEspecialidadesMedTradicional: lstEspecialidadesMedTradicional ??
            this.lstEspecialidadesMedTradicional,
        lstLugaresAtencionMedico:
            lstLugaresAtencionMedico ?? this.lstLugaresAtencionMedico,
        lstPlantasMedicinales:
            lstPlantasMedicinales ?? this.lstPlantasMedicinales,
        formStatus: formStatus ?? this.formStatus,
      );

  @override
  List<Object?> get props => [
        atencionSaludId,
        afiliadoId,
        familiaId,
        enfermedadAcudeId,
        recibioAtencionMedTradicionalId,
        enfermedadTratamientoId,
        utilizaPlantasMedId,
        lugarPlantaMedicinalId,
        lstEnfermedadesTradicionales,
        lstEspecialidadesMedTradicional,
        lstLugaresAtencionMedico,
        lstPlantasMedicinales,
        formStatus,
      ];
}
