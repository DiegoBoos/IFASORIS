import 'dart:convert';

import '../../domain/entities/etnia_entity.dart';

List<EtniaModel> etniasFromJson(String str) =>
    List<EtniaModel>.from(json.decode(str).map((x) => EtniaModel.fromJson(x)));

class EtniaModel extends EtniaEntity {
  EtniaModel({
    required int etniaId,
    required String descripcion,
  }) : super(
          etniaId: etniaId,
          descripcion: descripcion,
        );

  factory EtniaModel.fromJson(Map<String, dynamic> json) => EtniaModel(
        etniaId: json["Etnia_id"],
        descripcion: json["Descripcion"],
      );
}
