import 'dart:convert';

import '../../domain/entities/autoridad_indigena_entity.dart';

List<AutoridadIndigenaModel> autoridadesIndigenasFromJson(String str) =>
    List<AutoridadIndigenaModel>.from(
        json.decode(str).map((x) => AutoridadIndigenaModel.fromJson(x)));

class AutoridadIndigenaModel extends AutoridadIndigenaEntity {
  AutoridadIndigenaModel({
    required int autoridadIndigenaId,
    required String descripcion,
  }) : super(
          autoridadIndigenaId: autoridadIndigenaId,
          descripcion: descripcion,
        );

  factory AutoridadIndigenaModel.fromJson(Map<String, dynamic> json) =>
      AutoridadIndigenaModel(
        autoridadIndigenaId: json["AutoridadIndigena_id"],
        descripcion: json["Descripcion"],
      );
}
