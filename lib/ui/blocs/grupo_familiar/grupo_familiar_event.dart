part of 'grupo_familiar_bloc.dart';

abstract class GrupoFamiliarEvent extends Equatable {
  const GrupoFamiliarEvent();

  @override
  List<Object> get props => [];
}

class SaveGrupoFamiliar extends GrupoFamiliarEvent {
  final GrupoFamiliarEntity grupofamiliar;

  const SaveGrupoFamiliar(this.grupofamiliar);
}
