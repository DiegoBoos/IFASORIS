part of 'grupo_familiar_bloc.dart';

abstract class GrupoFamiliarEvent extends Equatable {
  const GrupoFamiliarEvent();

  @override
  List<Object> get props => [];
}

class GrupoFamiliarInit extends GrupoFamiliarEvent {}

class GrupoFamiliarReset extends GrupoFamiliarEvent {}

class GrupoFamiliarSubmitted extends GrupoFamiliarEvent {}

class GetGrupoFamiliar extends GrupoFamiliarEvent {
  final int familiaId;

  const GetGrupoFamiliar(this.familiaId);
}

class IsCompletedChanged extends GrupoFamiliarEvent {
  final bool isCompleted;

  const IsCompletedChanged(this.isCompleted);
}

class FamiliaRegistroChanged extends GrupoFamiliarEvent {
  final int familiaRegistroId;

  const FamiliaRegistroChanged(this.familiaRegistroId);
}

class TipoDocumentoChanged extends GrupoFamiliarEvent {
  final int tipoDocumentoId;

  const TipoDocumentoChanged(this.tipoDocumentoId);
}

class DocumentoChanged extends GrupoFamiliarEvent {
  final String documento;

  const DocumentoChanged(this.documento);
}

class NombresApellidosChanged extends GrupoFamiliarEvent {
  final String nombresApellidos;

  const NombresApellidosChanged(this.nombresApellidos);
}

class GeneroChanged extends GrupoFamiliarEvent {
  final int generoId;

  const GeneroChanged(this.generoId);
}

class FechaNacChanged extends GrupoFamiliarEvent {
  final String fechaNac;

  const FechaNacChanged(this.fechaNac);
}

class EdadChanged extends GrupoFamiliarEvent {
  final String edad;

  const EdadChanged(this.edad);
}

class CursoVidaChanged extends GrupoFamiliarEvent {
  final int cursoVida;

  const CursoVidaChanged(this.cursoVida);
}

class ParentescoChanged extends GrupoFamiliarEvent {
  final int parentescoId;

  const ParentescoChanged(this.parentescoId);
}

class RegimenChanged extends GrupoFamiliarEvent {
  final int regimenId;

  const RegimenChanged(this.regimenId);
}

class NivelEducativoChanged extends GrupoFamiliarEvent {
  final int nivelEducativoId;

  const NivelEducativoChanged(this.nivelEducativoId);
}

class OcupacionChanged extends GrupoFamiliarEvent {
  final int ocupacionId;

  const OcupacionChanged(this.ocupacionId);
}

class GrupoRiesgoChanged extends GrupoFamiliarEvent {
  final int grupoRiesgoId;

  const GrupoRiesgoChanged(this.grupoRiesgoId);
}

class EtniaChanged extends GrupoFamiliarEvent {
  final int etniaId;

  const EtniaChanged(this.etniaId);
}

class PuebloIndigenaChanged extends GrupoFamiliarEvent {
  final int puebloIndigenaId;

  const PuebloIndigenaChanged(this.puebloIndigenaId);
}

class LenguaManejaChanged extends GrupoFamiliarEvent {
  final int lenguaManejaId;

  const LenguaManejaChanged(this.lenguaManejaId);
}

class NombreLenguaMaternaChanged extends GrupoFamiliarEvent {
  final int nombreLenguaMaternaId;

  const NombreLenguaMaternaChanged(this.nombreLenguaMaternaId);
}
