part of 'afiliados_grupo_familiar_bloc.dart';

abstract class AfiliadosGrupoFamiliarState extends Equatable {
  final List<GrupoFamiliarEntity>? afiliadosGrupoFamiliar;

  const AfiliadosGrupoFamiliarState({this.afiliadosGrupoFamiliar});

  @override
  List<Object?> get props => [afiliadosGrupoFamiliar];
}

class AfiliadosGrupoFamiliarInitial extends AfiliadosGrupoFamiliarState {}

class AfiliadosGrupoFamiliarLoading extends AfiliadosGrupoFamiliarState {}

class AfiliadosGrupoFamiliarLoaded extends AfiliadosGrupoFamiliarState {
  final List<GrupoFamiliarEntity>? afiliadosGrupoFamiliarLoaded;
  final String message;

  const AfiliadosGrupoFamiliarLoaded(
      {this.afiliadosGrupoFamiliarLoaded, this.message = ''})
      : super(afiliadosGrupoFamiliar: afiliadosGrupoFamiliarLoaded);
}

class AfiliadosGrupoFamiliarError extends AfiliadosGrupoFamiliarState {
  final String message;

  const AfiliadosGrupoFamiliarError(
    this.message,
  );
}

class GrupoFamiliarSubmissionSuccess extends AfiliadosGrupoFamiliarState {
  final List<GrupoFamiliarEntity>? afiliadosGrupoFamiliarSuccess;

  const GrupoFamiliarSubmissionSuccess({this.afiliadosGrupoFamiliarSuccess})
      : super(afiliadosGrupoFamiliar: afiliadosGrupoFamiliarSuccess);
}


/* class AfiliadosGrupoFamiliarSaved extends AfiliadosGrupoFamiliarState {
  final List<GrupoFamiliarEntity>? afiliadosGrupoFamiliarSaved;
  final String message;

  const AfiliadosGrupoFamiliarSaved(
      {this.afiliadosGrupoFamiliarSaved, this.message = ''})
      : super(afiliadosGrupoFamiliar: afiliadosGrupoFamiliarSaved);
}
 */

/* class GrupoFamiliarSubmissionFailed extends AfiliadosGrupoFamiliarState {
  final String message;

  const GrupoFamiliarSubmissionFailed(this.message);
}
 */