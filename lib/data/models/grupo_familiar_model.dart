import 'dart:convert';

import '../../domain/entities/grupo_familiar_entity.dart';

GrupoFamiliarModel grupoFamiliarFromJson(String str) =>
    GrupoFamiliarModel.fromJson(json.decode(str));

class GrupoFamiliarModel extends GrupoFamiliarEntity {
  GrupoFamiliarModel({
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
  }) : super(
          grupoFamiliarId: grupoFamiliarId,
          familiaId: familiaId,
          afiliadoId: afiliadoId,
          tipoDocumentoId: tipoDocumentoId,
          documento: documento,
          generoId: generoId,
          fechaNacimiento: fechaNacimiento,
          edad: edad,
          nombre1: nombre1,
          nombre2: nombre2,
          apellido1: apellido1,
          apellido2: apellido2,
          tipoRegimenId: tipoRegimenId,
          parentescoId: parentescoId,
          etniaId: etniaId,
          cursoVidaId: cursoVidaId,
          nivelEducativoId: nivelEducativoId,
          ocupacionId: ocupacionId,
          grupoRiesgoId: grupoRiesgoId,
          origenEtnico5602Id: origenEtnico5602Id,
          puebloIndigenaId: puebloIndigenaId,
          lenguaManejaId: lenguaManejaId,
          lenguaMaternaId: lenguaMaternaId,
        );

  factory GrupoFamiliarModel.fromJson(Map<String, dynamic> json) =>
      GrupoFamiliarModel(
        grupoFamiliarId: json["GrupoFamiliar_id"],
        familiaId: json["Familia_id"],
        afiliadoId: json["Afiliado_id"],
        tipoDocumentoId: json["TipoDocumento_id"],
        documento: json["Documento"],
        generoId: json["Genero_id"],
        fechaNacimiento: json["FechaNacimiento"] == null
            ? null
            : DateTime.parse(json["FechaNacimiento"]),
        edad: json["Edad"],
        nombre1: json["nombre1"],
        nombre2: json["nombre2"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"],
        tipoRegimenId: json["TipoRegimen_id"],
        parentescoId: json["Parentesco_id"],
        etniaId: json["Etnia_id"],
        cursoVidaId: json["CursoVida_id"],
        nivelEducativoId: json["NivelEducativo_id"],
        ocupacionId: json["Ocupacion_id"],
        grupoRiesgoId: json["GrupoRiesgo_id"],
        origenEtnico5602Id: json["OrigenEtnico5602_id"],
        puebloIndigenaId: json["PuebloIndigena_id"],
        lenguaManejaId: json["LenguaManeja_id"],
        lenguaMaternaId: json["LenguaMaterna_id"],
      );
}
