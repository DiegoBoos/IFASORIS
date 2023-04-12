import 'dart:convert';

import '../../domain/entities/costo_desplazamiento_entity.dart';

List<CostoDesplazamientoModel> costosDesplazamientoModelFromJson(String str) =>
    List<CostoDesplazamientoModel>.from(
        json.decode(str).map((x) => CostoDesplazamientoModel.fromJson(x)));

class CostoDesplazamientoModel extends CostoDesplazamientoEntity {
  CostoDesplazamientoModel({
    required int costoDesplazamientoId,
    required String descripcion,
  }) : super(
          costoDesplazamientoId: costoDesplazamientoId,
          descripcion: descripcion,
        );

  factory CostoDesplazamientoModel.fromJson(Map<String, dynamic> json) =>
      CostoDesplazamientoModel(
        costoDesplazamientoId: json["costoDesplazamiento_id"],
        descripcion: json["descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "costoDesplazamiento_id": costoDesplazamientoId,
        "descripcion": descripcion,
      };
}
