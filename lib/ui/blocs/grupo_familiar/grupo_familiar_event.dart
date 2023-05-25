part of 'grupo_familiar_bloc.dart';

abstract class GrupoFamiliarEvent extends Equatable {
  const GrupoFamiliarEvent();

  @override
  List<Object> get props => [];
}

class GrupoFamiliarInit extends GrupoFamiliarEvent {}

class GrupoFamiliarReset extends GrupoFamiliarEvent {}

class GrupoFamiliarSubmitted extends GrupoFamiliarEvent {}

class GetGrupoFamiliar extends GrupoFamiliarEvent {
  final int familiaId;

  const GetGrupoFamiliar(this.familiaId);
}

class IsCompletedChanged extends GrupoFamiliarEvent {
  final bool isCompleted;

  const IsCompletedChanged(this.isCompleted);
}
