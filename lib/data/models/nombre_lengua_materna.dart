import 'dart:convert';

import '../../domain/entities/nombre_lengua_materna.dart';

List<NombreLenguaMaternaModel> nombresLenguasMaternaFromJson(String str) =>
    List<NombreLenguaMaternaModel>.from(
        json.decode(str).map((x) => NombreLenguaMaternaModel.fromJson(x)));

class NombreLenguaMaternaModel extends NombreLenguaMaternaEntity {
  const NombreLenguaMaternaModel({
    super.lenguaMaternaId,
    super.descripcion,
  });

  factory NombreLenguaMaternaModel.fromEntity(
      NombreLenguaMaternaEntity entity) {
    return NombreLenguaMaternaModel(
      lenguaMaternaId: entity.lenguaMaternaId,
      descripcion: entity.descripcion,
    );
  }

  factory NombreLenguaMaternaModel.fromJson(Map<String, dynamic> json) =>
      NombreLenguaMaternaModel(
        lenguaMaternaId: json["LenguaMaterna_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "LenguaMaterna_id": lenguaMaternaId,
        "Descripcion": descripcion,
      };
}
