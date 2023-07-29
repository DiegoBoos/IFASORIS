import 'dart:convert';

import 'package:ifasoris/domain/entities/lugar_planta_medicinal_entity.dart';

List<LugarPlantaMedicinalModel> lugaresPlantasMedicinalesFromJson(String str) =>
    List<LugarPlantaMedicinalModel>.from(
        json.decode(str).map((x) => LugarPlantaMedicinalModel.fromJson(x)));

class LugarPlantaMedicinalModel extends LugarPlantaMedicinalEntity {
  LugarPlantaMedicinalModel({
    required int lugarPlantaMedicinalId,
    required String descripcion,
  }) : super(
            lugarPlantaMedicinalId: lugarPlantaMedicinalId,
            descripcion: descripcion);

  factory LugarPlantaMedicinalModel.fromJson(Map<String, dynamic> json) =>
      LugarPlantaMedicinalModel(
        lugarPlantaMedicinalId: json["LugarPlantaMedicinal_id"],
        descripcion: json["Descripcion"],
      );
}
