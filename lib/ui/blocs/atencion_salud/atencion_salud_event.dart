part of 'atencion_salud_bloc.dart';

abstract class AtencionSaludEvent extends Equatable {
  const AtencionSaludEvent();

  @override
  List<Object> get props => [];
}

class AtencionSaludInit extends AtencionSaludEvent {}

class AtencionSaludSubmitted extends AtencionSaludEvent {}

class GetAtencionSalud extends AtencionSaludEvent {
  final int afiliadoId;

  const GetAtencionSalud(this.afiliadoId);
}

class AtencionSaludFormSubmissionSuccess extends AtencionSaludEvent {
  final int atencionSaludId;

  const AtencionSaludFormSubmissionSuccess(this.atencionSaludId);
}

class AtencionSaludFormSubmissionFailed extends AtencionSaludEvent {
  final String message;

  const AtencionSaludFormSubmissionFailed(this.message);
}

class AtencionSaludChanged extends AtencionSaludEvent {
  final int atencionSaludId;

  const AtencionSaludChanged(this.atencionSaludId);
}

class AfiliadoChanged extends AtencionSaludEvent {
  final int afiliadoId;

  const AfiliadoChanged(this.afiliadoId);
}

class FamiliaChanged extends AtencionSaludEvent {
  final int familiaId;

  const FamiliaChanged(this.familiaId);
}

class EnfermedadAcudeChanged extends AtencionSaludEvent {
  final int enfermedadAcudeId;

  const EnfermedadAcudeChanged(this.enfermedadAcudeId);
}

class RecibioAtencionMedTradicionalChanged extends AtencionSaludEvent {
  final int recibioAtencionMedTradicionalId;

  const RecibioAtencionMedTradicionalChanged(
      this.recibioAtencionMedTradicionalId);
}

class EnfermedadTratamientoChanged extends AtencionSaludEvent {
  final int enfermedadTratamientoId;

  const EnfermedadTratamientoChanged(this.enfermedadTratamientoId);
}

class UtilizaPlantasMedChanged extends AtencionSaludEvent {
  final int utilizaPlantasMedId;

  const UtilizaPlantasMedChanged(this.utilizaPlantasMedId);
}

class LugarPlantaMedicinalChanged extends AtencionSaludEvent {
  final int lugarPlantaMedicinalId;

  const LugarPlantaMedicinalChanged(this.lugarPlantaMedicinalId);
}

class GetEnfermedadesTradicionales extends AtencionSaludEvent {
  final int? atencionSaludId;

  const GetEnfermedadesTradicionales(this.atencionSaludId);
}

class EnfermedadesTradicionalesChanged extends AtencionSaludEvent {
  final List<LstEnfermedadTradicional> lstEnfermedadesTradicionales;

  const EnfermedadesTradicionalesChanged(this.lstEnfermedadesTradicionales);
}

class GetEspecialidadesMedTradicional extends AtencionSaludEvent {
  final int? atencionSaludId;

  const GetEspecialidadesMedTradicional(this.atencionSaludId);
}

class EspecialidadesMedTradicionalChanged extends AtencionSaludEvent {
  final List<LstEspMedTradicional> lstEspecialidadesMedTradicional;

  const EspecialidadesMedTradicionalChanged(
      this.lstEspecialidadesMedTradicional);
}

class GetLugaresAtencionMedico extends AtencionSaludEvent {
  final int? atencionSaludId;

  const GetLugaresAtencionMedico(this.atencionSaludId);
}

class LugaresAtencionMedicoChanged extends AtencionSaludEvent {
  final List<LstLugarAtencionMedico> lstLugaresAtencionMedico;

  const LugaresAtencionMedicoChanged(this.lstLugaresAtencionMedico);
}

class GetPlantasMedicinales extends AtencionSaludEvent {
  final int? atencionSaludId;

  const GetPlantasMedicinales(this.atencionSaludId);
}

class PlantasMedicinalesChanged extends AtencionSaludEvent {
  final List<LstPlantaMedicinal> lstPlantasMedicinales;

  const PlantasMedicinalesChanged(this.lstPlantasMedicinales);
}
