import '../../data/models/enfermedad_tradicional_model.dart';
import '../../data/models/especialidad_med_tradicional_model.dart';
import '../../data/models/lugar_atencion_medico_model.dart';
import '../../data/models/planta_medicinal_model.dart';
import '../../ui/blocs/atencion_salud/atencion_salud_bloc.dart';

class AtencionSaludEntity {
  AtencionSaludEntity(
      {this.atencionSaludId,
      this.afiliadoId,
      this.familiaId,
      this.enfermedadAcudeId,
      this.recibioAtencionMedTradicionalId,
      this.especialidadMedTradId,
      this.enfermedadTradicionalId,
      this.lugarAtencionMedicoId,
      this.enfermedadTratamientoId,
      this.utilizaPlantasMedId,
      this.lugarPlantaMedicinalId,
      this.plantaMedicinalId,
      this.lstEnfermedadesTradicionales,
      this.lstEspecialidadesMedTradicional,
      this.lstLugaresAtencionMedico,
      this.lstPlantasMedicinales,
      this.formStatus = const AtencionSaludFormInitial(),
      this.remoteAtencionSalud});

  int? atencionSaludId;
  int? afiliadoId;
  int? familiaId;
  int? enfermedadAcudeId;
  int? recibioAtencionMedTradicionalId;
  int? especialidadMedTradId;
  int? enfermedadTradicionalId;
  int? lugarAtencionMedicoId;
  int? enfermedadTratamientoId;
  int? utilizaPlantasMedId;
  int? lugarPlantaMedicinalId;
  int? plantaMedicinalId;
  List<LstEnfermedadTradicional>? lstEnfermedadesTradicionales;
  List<LstEspMedTradicional>? lstEspecialidadesMedTradicional;
  List<LstLugarAtencionMedico>? lstLugaresAtencionMedico;
  List<LstPlantaMedicinal>? lstPlantasMedicinales;
  AtencionSaludState formStatus;
  int? remoteAtencionSalud;

  AtencionSaludEntity copyWith({
    int? atencionSaludId,
    int? afiliadoId,
    int? familiaId,
    int? enfermedadAcudeId,
    int? recibioAtencionMedTradicionalId,
    int? especialidadMedTradId,
    int? enfermedadTradicionalId,
    int? lugarAtencionMedicoId,
    int? enfermedadTratamientoId,
    int? utilizaPlantasMedId,
    int? lugarPlantaMedicinalId,
    int? plantaMedicinalId,
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
        especialidadMedTradId:
            especialidadMedTradId ?? this.especialidadMedTradId,
        enfermedadTradicionalId:
            enfermedadTradicionalId ?? this.enfermedadTradicionalId,
        lugarAtencionMedicoId:
            lugarAtencionMedicoId ?? this.lugarAtencionMedicoId,
        enfermedadTratamientoId:
            enfermedadTratamientoId ?? this.enfermedadTratamientoId,
        utilizaPlantasMedId: utilizaPlantasMedId ?? this.utilizaPlantasMedId,
        lugarPlantaMedicinalId:
            lugarPlantaMedicinalId ?? this.lugarPlantaMedicinalId,
        plantaMedicinalId: plantaMedicinalId ?? this.plantaMedicinalId,
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
        "AtencionSalud_id": atencionSaludId,
        "Afiliado_id": afiliadoId,
        "Familia_id": familiaId,
        "EnfermedadAcude_id": enfermedadAcudeId,
        "RecibioAtencionMedTradicional_id": recibioAtencionMedTradicionalId,
        "EspecialidadMedTrad_id": especialidadMedTradId,
        "EnfermedadTradicional_id": enfermedadTradicionalId,
        "LugarAtencionMedico_id": lugarAtencionMedicoId,
        "EnfermedadTratamiento_id": enfermedadTratamientoId,
        "UtilizaPlantasMed_id": utilizaPlantasMedId,
        "LugarPlantaMedicinal_id": lugarPlantaMedicinalId,
        "PlantaMedicinal_id": plantaMedicinalId,
        "remoteAtencionSalud_id": remoteAtencionSalud,
      };
}
