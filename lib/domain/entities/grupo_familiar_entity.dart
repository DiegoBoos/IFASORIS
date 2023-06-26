import '../../ui/blocs/grupo_familiar/grupo_familiar_bloc.dart';

class GrupoFamiliarEntity {
  String? tipoDocumento;
  String? documento;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? genero;
  DateTime? fechaNac;
  int? edad;
  int? grupoFamiliarId;
  int? familiaId;
  int? afiliadoId;
  int? cursoVidaId;
  int? parentescoId;
  int? tipoRegimenId;
  int? nivelEducativoId;
  int? ocupacionId;
  int? grupoRiesgoId;
  int? origenEtnico5602Id;
  int? puebloIndigenaId;
  int? lenguaManejaId;
  int? lenguaMaternaId;
  bool? isCompleted;
  GrupoFamiliarState formStatus;
  int? remoteGrupoFamiliarId;

  GrupoFamiliarEntity(
      {this.tipoDocumento,
      this.documento,
      this.nombre1,
      this.nombre2,
      this.apellido1,
      this.apellido2,
      this.genero,
      this.fechaNac,
      this.edad,
      this.grupoFamiliarId,
      this.familiaId,
      this.afiliadoId,
      this.cursoVidaId,
      this.parentescoId,
      this.tipoRegimenId,
      this.nivelEducativoId,
      this.ocupacionId,
      this.grupoRiesgoId,
      this.origenEtnico5602Id,
      this.puebloIndigenaId,
      this.lenguaManejaId,
      this.lenguaMaternaId,
      this.isCompleted = false,
      this.formStatus = const GrupoFamiliarFormInitial(),
      this.remoteGrupoFamiliarId});

  GrupoFamiliarEntity copyWith({
    String? tipoDocumento,
    String? documento,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? genero,
    DateTime? fechaNac,
    int? grupoFamiliarId,
    int? familiaId,
    int? afiliadoId,
    int? cursoVidaId,
    int? parentescoId,
    int? tipoRegimenId,
    int? nivelEducativoId,
    int? ocupacionId,
    int? grupoRiesgoId,
    int? origenEtnico5602Id,
    int? puebloIndigenaId,
    int? lenguaManejaId,
    int? lenguaMaternaId,
    bool? isCompleted,
    GrupoFamiliarState? formStatus,
  }) =>
      GrupoFamiliarEntity(
        tipoDocumento: tipoDocumento ?? this.tipoDocumento,
        documento: documento ?? this.documento,
        nombre1: nombre1 ?? this.nombre1,
        nombre2: nombre2 ?? this.nombre2,
        apellido1: apellido1 ?? this.apellido1,
        apellido2: apellido2 ?? this.apellido2,
        genero: genero ?? this.genero,
        fechaNac: fechaNac ?? this.fechaNac,
        grupoFamiliarId: grupoFamiliarId ?? this.grupoFamiliarId,
        familiaId: familiaId ?? this.familiaId,
        afiliadoId: afiliadoId ?? this.afiliadoId,
        cursoVidaId: cursoVidaId ?? this.cursoVidaId,
        parentescoId: parentescoId ?? this.parentescoId,
        tipoRegimenId: tipoRegimenId ?? this.tipoRegimenId,
        nivelEducativoId: nivelEducativoId ?? this.nivelEducativoId,
        ocupacionId: ocupacionId ?? this.ocupacionId,
        grupoRiesgoId: grupoRiesgoId ?? this.grupoRiesgoId,
        origenEtnico5602Id: origenEtnico5602Id ?? this.origenEtnico5602Id,
        puebloIndigenaId: puebloIndigenaId ?? this.puebloIndigenaId,
        lenguaManejaId: lenguaManejaId ?? this.lenguaManejaId,
        lenguaMaternaId: lenguaMaternaId ?? this.lenguaMaternaId,
        isCompleted: isCompleted ?? this.isCompleted,
        formStatus: formStatus ?? this.formStatus,
      );

  Map<String, dynamic> toJson() => {
        "GrupoFamiliar_id": grupoFamiliarId,
        "Familia_id": familiaId,
        "Afiliado_id": afiliadoId,
        "CursoVida_id": cursoVidaId,
        "Parentesco_id": parentescoId,
        "TipoRegimen_id": tipoRegimenId,
        "NivelEducativo_id": nivelEducativoId,
        "Ocupacion_id": ocupacionId,
        "GrupoRiesgo_id": grupoRiesgoId,
        "OrigenEtnico5602_id": origenEtnico5602Id,
        "PuebloIndigena_id": puebloIndigenaId,
        "LenguaManeja_id": lenguaManejaId,
        "LenguaMaterna_id": lenguaMaternaId,
        "remoteGrupoFamiliar_id": remoteGrupoFamiliarId,
      };
}
