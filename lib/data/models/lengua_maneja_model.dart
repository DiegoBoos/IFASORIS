import 'dart:convert';

import '../../domain/entities/lengua_maneja_entity.dart';

List<LenguaManejaModel> lenguasManejaFromJson(String str) =>
    List<LenguaManejaModel>.from(
        json.decode(str).map((x) => LenguaManejaModel.fromJson(x)));

class LenguaManejaModel extends LenguaManejaEntity {
  LenguaManejaModel({
    required int lenguaManejaId,
    required String descripcion,
  }) : super(
          lenguaManejaId: lenguaManejaId,
          descripcion: descripcion,
        );

  factory LenguaManejaModel.fromJson(Map<String, dynamic> json) =>
      LenguaManejaModel(
        lenguaManejaId: json["LenguaManeja_id"],
        descripcion: json["Descripcion"],
      );
}
