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

class GetAfiliadosGrupoFamiliar extends AfiliadosGrupoFamiliarEvent {
  final int familiaId;

  const GetAfiliadosGrupoFamiliar(this.familiaId);
}

class AddOrEditAfiliadoGrupoFamiliar extends AfiliadosGrupoFamiliarEvent {
  final GrupoFamiliarEntity newAfiliado;

  const AddOrEditAfiliadoGrupoFamiliar(this.newAfiliado);
}

class ErrorAfiliadosGrupoFamiliar extends AfiliadosGrupoFamiliarEvent {
  final String message;

  const ErrorAfiliadosGrupoFamiliar(this.message);
}
