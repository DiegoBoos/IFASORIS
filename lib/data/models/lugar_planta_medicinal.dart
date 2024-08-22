import 'dart:convert';

import 'package:ifasoris/domain/entities/lugar_planta_medicinal.dart';

List<LugarPlantaMedicinalModel> lugaresPlantasMedicinalesFromJson(String str) =>
    List<LugarPlantaMedicinalModel>.from(
        json.decode(str).map((x) => LugarPlantaMedicinalModel.fromJson(x)));

class LugarPlantaMedicinalModel extends LugarPlantaMedicinalEntity {
  const LugarPlantaMedicinalModel({
    int? lugarPlantaMedicinalId,
    String? descripcion,
    int? departamentoId,
  }) : super(
          lugarPlantaMedicinalId: lugarPlantaMedicinalId,
          descripcion: descripcion,
          departamentoId: departamentoId,
        );

  static LugarPlantaMedicinalModel fromEntity(
      LugarPlantaMedicinalEntity entity) {
    return LugarPlantaMedicinalModel(
      lugarPlantaMedicinalId: entity.lugarPlantaMedicinalId,
      descripcion: entity.descripcion,
      departamentoId: entity.departamentoId,
    );
  }

  factory LugarPlantaMedicinalModel.fromJson(Map<String, dynamic> json) =>
      LugarPlantaMedicinalModel(
        lugarPlantaMedicinalId: json["LugarPlantaMedicinal_id"],
        descripcion: json["Descripcion"],
        departamentoId: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "LugarPlantaMedicinal_id": lugarPlantaMedicinalId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoId
      };
}
