part of 'grupo_familiar_bloc.dart';

abstract class GrupoFamiliarEvent extends Equatable {
  const GrupoFamiliarEvent();

  @override
  List<Object> get props => [];
}

class GrupoFamiliarInit extends GrupoFamiliarEvent {}

class SaveAfiliadoGrupoFamiliar extends GrupoFamiliarEvent {
  final GrupoFamiliarEntity grupoFamiliar;

  const SaveAfiliadoGrupoFamiliar(this.grupoFamiliar);
}

class FamiliaChanged extends GrupoFamiliarEvent {
  final int familiaId;

  const FamiliaChanged(this.familiaId);
}

class CursoVidaChanged extends GrupoFamiliarEvent {
  final int cursoVidaId;

  const CursoVidaChanged(this.cursoVidaId);
}

class ParentescoChanged extends GrupoFamiliarEvent {
  final int parentescoId;

  const ParentescoChanged(this.parentescoId);
}

class TipoRegimenChanged extends GrupoFamiliarEvent {
  final int tipoRegimenId;

  const TipoRegimenChanged(this.tipoRegimenId);
}

class NivelEducativoChanged extends GrupoFamiliarEvent {
  final int nivelEducativoId;

  const NivelEducativoChanged(this.nivelEducativoId);
}

class OcupacionChanged extends GrupoFamiliarEvent {
  final int ocupacionId;

  const OcupacionChanged(this.ocupacionId);
}

class OtroOcupacionChanged extends GrupoFamiliarEvent {
  final String? otroOcupacion;

  const OtroOcupacionChanged(this.otroOcupacion);
}

class GrupoRiesgoChanged extends GrupoFamiliarEvent {
  final int grupoRiesgoId;

  const GrupoRiesgoChanged(this.grupoRiesgoId);
}

class EtniaChanged extends GrupoFamiliarEvent {
  final int origenEtnico5602Id;

  const EtniaChanged(this.origenEtnico5602Id);
}

class PuebloIndigenaChanged extends GrupoFamiliarEvent {
  final int puebloIndigenaId;

  const PuebloIndigenaChanged(this.puebloIndigenaId);
}

class LenguaManejaChanged extends GrupoFamiliarEvent {
  final int lenguaManejaId;

  const LenguaManejaChanged(this.lenguaManejaId);
}

class LenguaMaternaChanged extends GrupoFamiliarEvent {
  final int lenguaMaternaId;

  const LenguaMaternaChanged(this.lenguaMaternaId);
}
