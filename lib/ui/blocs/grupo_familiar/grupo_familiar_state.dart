part of 'grupo_familiar_bloc.dart';

abstract class GrupoFamiliarState {
  const GrupoFamiliarState();
}

class GrupoFamiliarFormInitial extends GrupoFamiliarState {
  const GrupoFamiliarFormInitial();
}

GrupoFamiliarEntity initObject() {
  return GrupoFamiliarEntity(formStatus: const GrupoFamiliarFormInitial());
}
