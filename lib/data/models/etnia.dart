import 'dart:convert';

import '../../domain/entities/etnia.dart';

List<EtniaModel> etniasFromJson(String str) =>
    List<EtniaModel>.from(json.decode(str).map((x) => EtniaModel.fromJson(x)));

class EtniaModel extends EtniaEntity {
  const EtniaModel({
    super.etniaId,
    super.descripcion,
  });

  factory EtniaModel.fromEntity(EtniaEntity entity) {
    return EtniaModel(
      etniaId: entity.etniaId,
      descripcion: entity.descripcion,
    );
  }

  factory EtniaModel.fromJson(Map<String, dynamic> json) => EtniaModel(
        etniaId: json["Etnia_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Etnia_id": etniaId,
        "Descripcion": descripcion,
      };
}
