import 'dart:convert';

import 'package:ifasoris/domain/entities/estado_via_entity.dart';

List<EstadoViaModel> estadosViasModelFromJson(String str) =>
    List<EstadoViaModel>.from(
        json.decode(str).map((x) => EstadoViaModel.fromJson(x)));

class EstadoViaModel extends EstadoViaEntity {
  EstadoViaModel({
    required int estadoViaId,
    required String descripcion,
  }) : super(estadoViaId: estadoViaId, descripcion: descripcion);

  factory EstadoViaModel.fromJson(Map<String, dynamic> json) => EstadoViaModel(
        estadoViaId: json["estadoVia_id"],
        descripcion: json["descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "estadoVia_id": estadoViaId,
        "descripcion": descripcion,
      };
}
