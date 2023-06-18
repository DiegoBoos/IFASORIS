import 'dart:convert';

import '../../domain/entities/curso_vida_entity.dart';

List<CursoVidaModel> cursosVidaFromJson(String str) =>
    List<CursoVidaModel>.from(
        json.decode(str).map((x) => CursoVidaModel.fromJson(x)));

class CursoVidaModel extends CursoVidaEntity {
  CursoVidaModel({
    required int cursoVidaId,
    required String descripcion,
    required String rango,
  }) : super(
          cursoVidaId: cursoVidaId,
          descripcion: descripcion,
          rango: rango,
        );

  factory CursoVidaModel.fromJson(Map<String, dynamic> json) => CursoVidaModel(
        cursoVidaId: json["CursoVida_id"],
        descripcion: json["Descripcion"],
        rango: json["Rango"],
      );
}
