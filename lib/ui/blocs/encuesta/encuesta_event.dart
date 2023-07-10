part of 'encuesta_bloc.dart';

abstract class EncuestaEvent extends Equatable {
  const EncuestaEvent();

  @override
  List<Object> get props => [];
}

class SaveAfiliadosEncuesta extends EncuestaEvent {
  final List<GrupoFamiliarEntity> afiliadosGrupoFamiliar;

  const SaveAfiliadosEncuesta(this.afiliadosGrupoFamiliar);
}

class UpdatePercentage extends EncuestaEvent {
  final double newPercentage;

  const UpdatePercentage(this.newPercentage);
}
