import 'dart:convert';

import '../../domain/entities/autoridad_indigena.dart';

List<AutoridadIndigenaModel> autoridadesIndigenasFromJson(String str) =>
    List<AutoridadIndigenaModel>.from(
        json.decode(str).map((x) => AutoridadIndigenaModel.fromJson(x)));

class AutoridadIndigenaModel extends AutoridadIndigenaEntity {
  const AutoridadIndigenaModel(
      {int? autoridadIndigenaId, String? descripcion, int? departamentoId})
      : super(
            autoridadIndigenaId: autoridadIndigenaId,
            descripcion: descripcion,
            departamentoId: departamentoId);

  static AutoridadIndigenaModel fromEntity(AutoridadIndigenaEntity entity) {
    return AutoridadIndigenaModel(
        autoridadIndigenaId: entity.autoridadIndigenaId,
        descripcion: entity.descripcion,
        departamentoId: entity.departamentoId);
  }

  factory AutoridadIndigenaModel.fromJson(Map<String, dynamic> json) =>
      AutoridadIndigenaModel(
          autoridadIndigenaId: json["AutoridadIndigena_id"],
          descripcion: json["Descripcion"],
          departamentoId: json["Departamento_Ide"]);

  Map<String, dynamic> toJson() => {
        "AutoridadIndigena_id": autoridadIndigenaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoId
      };
}
