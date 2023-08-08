import '../../ui/blocs/grupo_familiar/grupo_familiar_bloc.dart';

class GrupoFamiliarEntity {
  int? grupoFamiliarId;
  int? familiaId;
  int? afiliadoId;
  int? tipoDocumentoId;
  String? documento;
  int? generoId;
  DateTime? fechaNacimiento;
  int? edad;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? tipoDocAfiliado;
  String? codGeneroAfiliado;
  String? codRegimenAfiliado;
  int? tipoRegimenId;
  int? parentescoId;
  int? etniaId;
  int? cursoVidaId;
  int? nivelEducativoId;
  int? ocupacionId;
  int? grupoRiesgoId;
  int? origenEtnico5602Id;
  int? puebloIndigenaId;
  int? lenguaManejaId;
  int? lenguaMaternaId;
  bool? isCompleted;
  GrupoFamiliarState formStatus;

  GrupoFamiliarEntity(
      {this.grupoFamiliarId,
      this.familiaId,
      this.afiliadoId,
      this.tipoDocumentoId,
      this.documento,
      this.generoId,
      this.fechaNacimiento,
      this.edad,
      this.nombre1,
      this.nombre2,
      this.apellido1,
      this.apellido2,
      this.tipoDocAfiliado,
      this.codGeneroAfiliado,
      this.codRegimenAfiliado,
      this.tipoRegimenId,
      this.parentescoId,
      this.etniaId,
      this.cursoVidaId,
      this.nivelEducativoId,
      this.ocupacionId,
      this.grupoRiesgoId,
      this.origenEtnico5602Id,
      this.puebloIndigenaId,
      this.lenguaManejaId,
      this.lenguaMaternaId,
      this.isCompleted = false,
      this.formStatus = const GrupoFamiliarFormInitial()});

  GrupoFamiliarEntity copyWith({
    int? grupoFamiliarId,
    int? familiaId,
    int? afiliadoId,
    int? tipoDocumentoId,
    String? documento,
    int? generoId,
    DateTime? fechaNacimiento,
    int? edad,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? tipoDocAfiliado,
    String? codGeneroAfiliado,
    String? codRegimenAfiliado,
    int? tipoRegimenId,
    int? parentescoId,
    int? etniaId,
    int? cursoVidaId,
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
        grupoFamiliarId: grupoFamiliarId ?? this.grupoFamiliarId,
        familiaId: familiaId ?? this.familiaId,
        afiliadoId: afiliadoId ?? this.afiliadoId,
        tipoDocumentoId: tipoDocumentoId ?? this.tipoDocumentoId,
        documento: documento ?? this.documento,
        generoId: generoId ?? this.generoId,
        fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
        edad: edad ?? this.edad,
        nombre1: nombre1 ?? this.nombre1,
        nombre2: nombre2 ?? this.nombre2,
        apellido1: apellido1 ?? this.apellido1,
        apellido2: apellido2 ?? this.apellido2,
        tipoDocAfiliado: tipoDocAfiliado ?? this.tipoDocAfiliado,
        codGeneroAfiliado: codGeneroAfiliado ?? this.codGeneroAfiliado,
        codRegimenAfiliado: codRegimenAfiliado ?? this.codRegimenAfiliado,
        tipoRegimenId: tipoRegimenId ?? this.tipoRegimenId,
        parentescoId: parentescoId ?? this.parentescoId,
        etniaId: etniaId ?? this.etniaId,
        cursoVidaId: cursoVidaId ?? this.cursoVidaId,
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
        "TipoDocumento_id": tipoDocumentoId,
        "Documento": documento,
        "Genero_id": generoId,
        "FechaNacimiento": fechaNacimiento?.toIso8601String(),
        "Edad": edad,
        "TipoRegimen_id": tipoRegimenId,
        "Parentesco_id": parentescoId,
        "Etnia_id": etniaId,
        "CursoVida_id": cursoVidaId,
        "NivelEducativo_id": nivelEducativoId,
        "Ocupacion_id": ocupacionId,
        "GrupoRiesgo_id": grupoRiesgoId,
        "OrigenEtnico5602_id": origenEtnico5602Id,
        "PuebloIndigena_id": puebloIndigenaId,
        "LenguaManeja_id": lenguaManejaId,
        "LenguaMaterna_id": lenguaMaternaId
      };
}
