part of 'grupo_familiar_bloc.dart';

abstract class GrupoFamiliarState {
  const GrupoFamiliarState();
}

class GrupoFamiliarFormInitial extends GrupoFamiliarState {
  const GrupoFamiliarFormInitial();
}

class GrupoFamiliarFormLoaded extends GrupoFamiliarState {}

class GrupoFamiliarFormEmpty extends GrupoFamiliarState {}

class GrupoFamiliarSubmissionSuccess extends GrupoFamiliarState {}

class GrupoFamiliarSubmissionFailed extends GrupoFamiliarState {
  final String message;

  GrupoFamiliarSubmissionFailed(this.message);
}
