part of 'afiliados_grupo_familiar_bloc.dart';

abstract class AfiliadosGrupoFamiliarEvent extends Equatable {
  const AfiliadosGrupoFamiliarEvent();

  @override
  List<Object> get props => [];
}

class ExisteAfiliadoCabezaFamilia extends AfiliadosGrupoFamiliarEvent {
  final int familiaId;
  const ExisteAfiliadoCabezaFamilia(this.familiaId);
}

class AddAfiliadoGrupoFamiliar extends AfiliadosGrupoFamiliarEvent {
  final GrupoFamiliarEntity grupoFamiliar;

  const AddAfiliadoGrupoFamiliar(this.grupoFamiliar);
}

class GetAfiliadosGrupoFamiliar extends AfiliadosGrupoFamiliarEvent {
  final int familiaId;

  const GetAfiliadosGrupoFamiliar(this.familiaId);
}

class ErrorAfiliadosGrupoFamiliar extends AfiliadosGrupoFamiliarEvent {
  final String message;

  const ErrorAfiliadosGrupoFamiliar(this.message);
}
