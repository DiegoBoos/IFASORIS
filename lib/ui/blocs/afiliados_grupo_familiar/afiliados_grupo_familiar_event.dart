part of 'afiliados_grupo_familiar_bloc.dart';

abstract class AfiliadosGrupoFamiliarEvent extends Equatable {
  const AfiliadosGrupoFamiliarEvent();

  @override
  List<Object> get props => [];
}

class GetAfiliadosGrupoFamiliar extends AfiliadosGrupoFamiliarEvent {
  final int familiaId;

  const GetAfiliadosGrupoFamiliar(this.familiaId);
}

class SaveAfiliadosGrupoFamiliar extends AfiliadosGrupoFamiliarEvent {
  final List<GrupoFamiliarEntity> afiliadosGrupoFamiliar;

  const SaveAfiliadosGrupoFamiliar(this.afiliadosGrupoFamiliar);
}

class CreateOrUpdateAfiliadoGrupoFamiliar extends AfiliadosGrupoFamiliarEvent {
  final GrupoFamiliarEntity newAfiliado;

  const CreateOrUpdateAfiliadoGrupoFamiliar(this.newAfiliado);
}

class ErrorMessage extends AfiliadosGrupoFamiliarEvent {
  final String message;

  const ErrorMessage(this.message);
}
