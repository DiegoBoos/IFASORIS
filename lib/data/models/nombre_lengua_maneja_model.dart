import 'dart:convert';

import '../../domain/entities/nombre_lengua_maneja_entity.dart';

List<NombreLenguaManejaModel> nombresLenguasManejaFromJson(String str) =>
    List<NombreLenguaManejaModel>.from(
        json.decode(str).map((x) => NombreLenguaManejaModel.fromJson(x)));

class NombreLenguaManejaModel extends NombreLenguaManejaEntity {
  NombreLenguaManejaModel({
    required int lenguaMaternaId,
    required String descripcion,
  }) : super(
          lenguaMaternaId: lenguaMaternaId,
          descripcion: descripcion,
        );

  factory NombreLenguaManejaModel.fromJson(Map<String, dynamic> json) =>
      NombreLenguaManejaModel(
        lenguaMaternaId: json["LenguaMaterna_id"],
        descripcion: json["Descripcion"],
      );
}
