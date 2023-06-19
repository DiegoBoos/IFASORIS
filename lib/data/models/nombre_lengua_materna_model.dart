import 'dart:convert';

import '../../domain/entities/nombre_lengua_materna_entity.dart';

List<NombreLenguaMaternaModel> nombresLenguasMaternaFromJson(String str) =>
    List<NombreLenguaMaternaModel>.from(
        json.decode(str).map((x) => NombreLenguaMaternaModel.fromJson(x)));

class NombreLenguaMaternaModel extends NombreLenguaMaternaEntity {
  NombreLenguaMaternaModel({
    required int lenguaMaternaId,
    required String descripcion,
  }) : super(
          lenguaMaternaId: lenguaMaternaId,
          descripcion: descripcion,
        );

  factory NombreLenguaMaternaModel.fromJson(Map<String, dynamic> json) =>
      NombreLenguaMaternaModel(
        lenguaMaternaId: json["LenguaMaterna_id"],
        descripcion: json["Descripcion"],
      );
}
