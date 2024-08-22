import 'dart:convert';

import '../../domain/entities/curso_vida.dart';

List<CursoVidaModel> cursosVidaFromJson(String str) =>
    List<CursoVidaModel>.from(
        json.decode(str).map((x) => CursoVidaModel.fromJson(x)));

class CursoVidaModel extends CursoVidaEntity {
  const CursoVidaModel({
    int? cursoVidaId,
    String? descripcion,
    String? rango,
  }) : super(
          cursoVidaId: cursoVidaId,
          descripcion: descripcion,
          rango: rango,
        );

  static CursoVidaModel fromEntity(CursoVidaEntity entity) {
    return CursoVidaModel(
      cursoVidaId: entity.cursoVidaId,
      descripcion: entity.descripcion,
      rango: entity.rango,
    );
  }

  factory CursoVidaModel.fromJson(Map<String, dynamic> json) => CursoVidaModel(
        cursoVidaId: json["CursoVida_id"],
        descripcion: json["Descripcion"],
        rango: json["Rango"],
      );

  Map<String, dynamic> toJson() => {
        "CursoVida_id": cursoVidaId,
        "Descripcion": descripcion,
        "Rango": rango,
      };
}
