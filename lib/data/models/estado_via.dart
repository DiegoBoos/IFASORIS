import 'dart:convert';

import 'package:ifasoris/domain/entities/estado_via.dart';

List<EstadoViaModel> estadosViasFromJson(String str) =>
    List<EstadoViaModel>.from(
        json.decode(str).map((x) => EstadoViaModel.fromJson(x)));

class EstadoViaModel extends EstadoViaEntity {
  const EstadoViaModel({
    int? estadoViaId,
    String? descripcion,
  }) : super(
          estadoViaId: estadoViaId,
          descripcion: descripcion,
        );

  static EstadoViaModel fromEntity(EstadoViaEntity entity) {
    return EstadoViaModel(
      estadoViaId: entity.estadoViaId,
      descripcion: entity.descripcion,
    );
  }

  factory EstadoViaModel.fromJson(Map<String, dynamic> json) => EstadoViaModel(
        estadoViaId: json["EstadoVia_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "EstadoVia_id": estadoViaId,
        "Descripcion": descripcion,
      };
}
