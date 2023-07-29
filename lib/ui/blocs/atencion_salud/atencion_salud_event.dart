part of 'atencion_salud_bloc.dart';

abstract class AtencionSaludEvent extends Equatable {
  const AtencionSaludEvent();

  @override
  List<Object> get props => [];
}

class AtencionSaludInit extends AtencionSaludEvent {}

class AtencionSaludSubmitted extends AtencionSaludEvent {
  final AtencionSaludEntity atencionSalud;

  const AtencionSaludSubmitted(this.atencionSalud);
}

class GetAtencionSalud extends AtencionSaludEvent {
  final int afiliadoId;

  const GetAtencionSalud(this.afiliadoId);
}

class AtencionSaludFormSubmissionSuccess extends AtencionSaludEvent {
  final int ubicacionId;

  const AtencionSaludFormSubmissionSuccess(this.ubicacionId);
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

class EnfermedadTratamientoChanged extends AtencionSaludEvent {
  final int enfermedadTratamientoId;

  const EnfermedadTratamientoChanged(this.enfermedadTratamientoId);
}

class EnfermedadTradicionalChanged extends AtencionSaludEvent {
  final int enfermedadTradicionalId;

  const EnfermedadTradicionalChanged(this.enfermedadTradicionalId);
}

class PlantaMedicinalChanged extends AtencionSaludEvent {
  final int plantaMedicinalId;

  const PlantaMedicinalChanged(this.plantaMedicinalId);
}

class UtilizaMetodoPlanificacionChanged extends AtencionSaludEvent {
  final int utilizaMetodoPlanificacionId;

  const UtilizaMetodoPlanificacionChanged(this.utilizaMetodoPlanificacionId);
}

class EnfermedadesTradicionalesChanged extends AtencionSaludEvent {
  final List<LstEnfermedadTradicional> lstEnfermedadesTradicionales;

  const EnfermedadesTradicionalesChanged(this.lstEnfermedadesTradicionales);
}

class EspecialidadesMedTradicionalChanged extends AtencionSaludEvent {
  final List<LstEspMedTradicional> lstEspecialidadesMedTradicional;

  const EspecialidadesMedTradicionalChanged(
      this.lstEspecialidadesMedTradicional);
}

class LugaresAtencionMedicoChanged extends AtencionSaludEvent {
  final List<LstLugarAtencionMedico> lstLugaresAtencionMedico;

  const LugaresAtencionMedicoChanged(this.lstLugaresAtencionMedico);
}

class PlantasMedicinalesChanged extends AtencionSaludEvent {
  final List<LstPlantaMedicinal> lstPlantasMedicinales;

  const PlantasMedicinalesChanged(this.lstPlantasMedicinales);
}
