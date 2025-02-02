import 'dart:convert';

import '../../domain/entities/grupo_familiar.dart';

List<GrupoFamiliarModel> listGrupoFamiliarFromJson(String str) =>
    List<GrupoFamiliarModel>.from(
        json.decode(str).map((x) => GrupoFamiliarModel.fromJson(x)));

GrupoFamiliarModel grupoFamiliarFromJson(String str) =>
    GrupoFamiliarModel.fromJson(json.decode(str));

class GrupoFamiliarModel extends GrupoFamiliarEntity {
  const GrupoFamiliarModel({
    super.grupoFamiliarId,
    super.familiaId,
    super.afiliadoId,
    super.tipoDocumentoId,
    super.documento,
    super.generoId,
    super.fechaNacimiento,
    super.edad,
    super.nombre1,
    super.nombre2,
    super.apellido1,
    super.apellido2,
    super.tipoDocAfiliado,
    super.codGeneroAfiliado,
    super.codRegimenAfiliado,
    super.tipoRegimenId,
    super.parentescoId,
    super.etniaId,
    super.cursoVidaId,
    super.nivelEducativoId,
    super.ocupacionId,
    super.otroOcupacion,
    super.grupoRiesgoId,
    super.origenEtnico5602Id,
    super.puebloIndigenaId,
    super.lenguaManejaId,
    super.lenguaMaternaId,
    super.isComplete,
  });

  factory GrupoFamiliarModel.fromEntity(GrupoFamiliarEntity entity) {
    return GrupoFamiliarModel(
      grupoFamiliarId: entity.grupoFamiliarId,
      familiaId: entity.familiaId,
      afiliadoId: entity.afiliadoId,
      tipoDocumentoId: entity.tipoDocumentoId,
      documento: entity.documento,
      generoId: entity.generoId,
      fechaNacimiento: entity.fechaNacimiento,
      edad: entity.edad,
      nombre1: entity.nombre1,
      nombre2: entity.nombre2,
      apellido1: entity.apellido1,
      apellido2: entity.apellido2,
      tipoDocAfiliado: entity.tipoDocAfiliado,
      codGeneroAfiliado: entity.codGeneroAfiliado,
      codRegimenAfiliado: entity.codRegimenAfiliado,
      tipoRegimenId: entity.tipoRegimenId,
      parentescoId: entity.parentescoId,
      etniaId: entity.etniaId,
      cursoVidaId: entity.cursoVidaId,
      nivelEducativoId: entity.nivelEducativoId,
      ocupacionId: entity.ocupacionId,
      otroOcupacion: entity.otroOcupacion,
      grupoRiesgoId: entity.grupoRiesgoId,
      origenEtnico5602Id: entity.origenEtnico5602Id,
      puebloIndigenaId: entity.puebloIndigenaId,
      lenguaManejaId: entity.lenguaManejaId,
      lenguaMaternaId: entity.lenguaMaternaId,
      isComplete: entity.isComplete,
    );
  }

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
          nombre2: json["nombre2"] ?? '',
          apellido1: json["apellido1"],
          apellido2: json["apellido2"] ?? '',
          tipoDocAfiliado: json["TipoDocAfiliado"],
          codGeneroAfiliado: json["CodGeneroAfiliado"],
          codRegimenAfiliado: json["CodRegimenAfiliado"],
          tipoRegimenId: json["TipoRegimen_id"],
          parentescoId: json["Parentesco_id"],
          etniaId: json["Etnia_id"],
          cursoVidaId: json["CursoVida_id"],
          nivelEducativoId: json["NivelEducativo_id"],
          ocupacionId: json["Ocupacion_id"],
          otroOcupacion: json["OtroOcupacion"],
          grupoRiesgoId: json["GrupoRiesgo_id"],
          origenEtnico5602Id: json["OrigenEtnico5602_id"],
          puebloIndigenaId: json["PuebloIndigena_id"],
          lenguaManejaId: json["LenguaManeja_id"],
          lenguaMaternaId: json["LenguaMaterna_id"],
          isComplete: json["isComplete"] ?? 0);

  Map<String, dynamic> toJson() => {
        "       GrupoFamiliar_id": grupoFamiliarId,
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
        "OtroOcupacion": otroOcupacion,
        "GrupoRiesgo_id": grupoRiesgoId,
        "OrigenEtnico5602_id": origenEtnico5602Id,
        "PuebloIndigena_id": puebloIndigenaId,
        "LenguaManeja_id": lenguaManejaId,
        "LenguaMaterna_id": lenguaMaternaId,
        "isComplete": isComplete,
      };
}
