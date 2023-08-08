import '../../data/models/enfermedad_tradicional_model.dart';
import '../../data/models/especialidad_med_tradicional_model.dart';
import '../../data/models/lugar_atencion_medico_model.dart';
import '../../data/models/planta_medicinal_model.dart';
import '../../ui/blocs/atencion_salud/atencion_salud_bloc.dart';

class AtencionSaludEntity {
  AtencionSaludEntity({
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

  int? atencionSaludId;
  int? afiliadoId;
  int? familiaId;
  int? enfermedadAcudeId;
  int? recibioAtencionMedTradicionalId;
  int? enfermedadTratamientoId;
  int? utilizaPlantasMedId;
  int? lugarPlantaMedicinalId;
  List<LstEnfermedadTradicional>? lstEnfermedadesTradicionales;
  List<LstEspMedTradicional>? lstEspecialidadesMedTradicional;
  List<LstLugarAtencionMedico>? lstLugaresAtencionMedico;
  List<LstPlantaMedicinal>? lstPlantasMedicinales;
  AtencionSaludState formStatus;

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

  Map<String, dynamic> toJson() => {
        "Afiliado_id": afiliadoId,
        "Familia_id": familiaId,
        "EnfermedadAcude_id": enfermedadAcudeId,
        "RecibioAtencionMedTradicional_id": recibioAtencionMedTradicionalId,
        "EnfermedadTratamiento_id": enfermedadTratamientoId,
        "UtilizaPlantasMed_id": utilizaPlantasMedId,
        "LugarPlantaMedicinal_id": lugarPlantaMedicinalId
      };
}
