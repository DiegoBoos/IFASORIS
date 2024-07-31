import 'dart:convert';

import '../../domain/entities/autoridad_indigena.dart';

List<AutoridadIndigenaModel> autoridadesIndigenasFromJson(String str) =>
    List<AutoridadIndigenaModel>.from(
        json.decode(str).map((x) => AutoridadIndigenaModel.fromJson(x)));

class AutoridadIndigenaModel extends AutoridadIndigenaEntity {
  const AutoridadIndigenaModel({
    int? autoridadIndigenaId,
    String? descripcion,
  });

  static AutoridadIndigenaModel fromEntity(AutoridadIndigenaEntity entity) {
    return AutoridadIndigenaModel(
      autoridadIndigenaId: entity.autoridadIndigenaId,
      descripcion: entity.descripcion,
    );
  }

  factory AutoridadIndigenaModel.fromJson(Map<String, dynamic> json) =>
      AutoridadIndigenaModel(
        autoridadIndigenaId: json["AutoridadIndigena_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "AutoridadIndigena_id": autoridadIndigenaId,
        "Descripcion": descripcion,
      };
}
