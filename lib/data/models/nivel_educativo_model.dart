import 'dart:convert';

import '../../domain/entities/nivel_educativo_entity.dart';

List<NivelEducativoModel> nivelesEducativosFromJson(String str) =>
    List<NivelEducativoModel>.from(
        json.decode(str).map((x) => NivelEducativoModel.fromJson(x)));

class NivelEducativoModel extends NivelEducativoEntity {
  NivelEducativoModel({
    required int nivelEducativoId,
    required String descripcion,
  }) : super(
          nivelEducativoId: nivelEducativoId,
          descripcion: descripcion,
        );

  factory NivelEducativoModel.fromJson(Map<String, dynamic> json) =>
      NivelEducativoModel(
        nivelEducativoId: json["NivelEducativo_id"],
        descripcion: json["Descripcion"],
      );
}
