part of 'afiliados_grupo_familiar_bloc.dart';

abstract class AfiliadosGrupoFamiliarState extends Equatable {
  final List<GrupoFamiliarEntity>? afiliadosGrupoFamiliar;

  const AfiliadosGrupoFamiliarState({this.afiliadosGrupoFamiliar});

  @override
  List<Object?> get props => [afiliadosGrupoFamiliar];
}

class AfiliadosGrupoFamiliarInitial extends AfiliadosGrupoFamiliarState {}

class GrupoFamiliarSubmissionSuccess extends AfiliadosGrupoFamiliarState {}

class GrupoFamiliarSubmissionFailed extends AfiliadosGrupoFamiliarState {
  final String message;

  const GrupoFamiliarSubmissionFailed(this.message);
}

class AfiliadosGrupoFamiliarEmpty extends AfiliadosGrupoFamiliarState {}

class AfiliadosGrupoFamiliarLoaded extends AfiliadosGrupoFamiliarState {
  final List<GrupoFamiliarEntity>? afiliadosGrupoFamiliarLoaded;

  const AfiliadosGrupoFamiliarLoaded({this.afiliadosGrupoFamiliarLoaded})
      : super(afiliadosGrupoFamiliar: afiliadosGrupoFamiliarLoaded);
}

class AfiliadosGrupoFamiliarError extends AfiliadosGrupoFamiliarState {
  final String message;
  final List<GrupoFamiliarEntity>? currentAfiliadosGrupoFamiliar;

  const AfiliadosGrupoFamiliarError(this.message,
      {this.currentAfiliadosGrupoFamiliar})
      : super(afiliadosGrupoFamiliar: currentAfiliadosGrupoFamiliar);
}
