part of 'grupo_familiar_bloc.dart';

abstract class GrupoFamiliarState {
  const GrupoFamiliarState();
}

class GrupoFamiliarFormInitial extends GrupoFamiliarState {
  const GrupoFamiliarFormInitial();
}

class GrupoFamiliarFormLoading extends GrupoFamiliarState {}

class GrupoFamiliarFormLoaded extends GrupoFamiliarState {}

class GrupoFamiliarFormEmpty extends GrupoFamiliarState {}

class GrupoFamiliarSubmissionSuccess extends GrupoFamiliarState {}

class GrupoFamiliarCompleted extends GrupoFamiliarState {}

class NuevoGrupoFamiliar extends GrupoFamiliarState {}

class GrupoFamiliarError extends GrupoFamiliarState {
  final String message;

  GrupoFamiliarError(this.message);
}

class GrupoFamiliarErrorAndPop extends GrupoFamiliarState {
  final String message;

  GrupoFamiliarErrorAndPop(this.message);
}

GrupoFamiliarEntity initObject() {
  return const GrupoFamiliarEntity(formStatus: GrupoFamiliarFormInitial());
}
