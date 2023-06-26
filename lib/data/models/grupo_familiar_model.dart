import 'dart:convert';

import '../../domain/entities/grupo_familiar_entity.dart';

GrupoFamiliarModel grupoFamiliarFromJson(String str) =>
    GrupoFamiliarModel.fromJson(json.decode(str));

class GrupoFamiliarModel extends GrupoFamiliarEntity {
  GrupoFamiliarModel({
    String? tipoDocumento,
    String? documento,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? genero,
    DateTime? fechaNac,
    required int grupoFamiliarId,
    required int familiaId,
    required int afiliadoId,
    required int cursoVidaId,
    required int parentescoId,
    required int tipoRegimenId,
    required int nivelEducativoId,
    required int ocupacionId,
    required int grupoRiesgoId,
    required int origenEtnico5602Id,
    required int puebloIndigenaId,
    required int lenguaManejaId,
    required int lenguaMaternaId,
  }) : super(
          tipoDocumento: tipoDocumento,
          documento: documento,
          nombre1: nombre1,
          nombre2: nombre2,
          apellido1: apellido1,
          apellido2: apellido2,
          genero: genero,
          fechaNac: fechaNac,
          grupoFamiliarId: grupoFamiliarId,
          familiaId: familiaId,
          afiliadoId: afiliadoId,
          cursoVidaId: cursoVidaId,
          parentescoId: parentescoId,
          tipoRegimenId: tipoRegimenId,
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
        tipoDocumento: json["TipoDoc_Afiliado"],
        documento: json["documento"],
        nombre1: json["nombre1"],
        nombre2: json["nombre2"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"],
        genero: json["CodGenero_Afiliado"],
        fechaNac: DateTime.parse(json["fecnac"]),
        grupoFamiliarId: json["GrupoFamiliar_id"],
        familiaId: json["Familia_id"],
        afiliadoId: json["Afiliado_id"],
        cursoVidaId: json["CursoVida_id"],
        parentescoId: json["Parentesco_id"],
        tipoRegimenId: json["TipoRegimen_id"],
        nivelEducativoId: json["NivelEducativo_id"],
        ocupacionId: json["Ocupacion_id"],
        grupoRiesgoId: json["GrupoRiesgo_id"],
        origenEtnico5602Id: json["OrigenEtnico5602_id"],
        puebloIndigenaId: json["PuebloIndigena_id"],
        lenguaManejaId: json["LenguaManeja_id"],
        lenguaMaternaId: json["LenguaMaterna_id"],
      );
}
