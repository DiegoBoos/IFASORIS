import 'dart:convert';

import '../../domain/entities/lengua_maneja.dart';

List<LenguaManejaModel> lenguasManejaFromJson(String str) =>
    List<LenguaManejaModel>.from(
        json.decode(str).map((x) => LenguaManejaModel.fromJson(x)));

class LenguaManejaModel extends LenguaManejaEntity {
  const LenguaManejaModel({
    super.lenguaManejaId,
    super.descripcion,
  });

  factory LenguaManejaModel.fromEntity(LenguaManejaEntity entity) {
    return LenguaManejaModel(
      lenguaManejaId: entity.lenguaManejaId,
      descripcion: entity.descripcion,
    );
  }

  factory LenguaManejaModel.fromJson(Map<String, dynamic> json) =>
      LenguaManejaModel(
        lenguaManejaId: json["LenguaManeja_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "LenguaManeja_id": lenguaManejaId,
        "Descripcion": descripcion,
      };
}
