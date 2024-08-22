import 'dart:convert';

import '../../domain/entities/costo_desplazamiento.dart';

List<CostoDesplazamientoModel> costosDesplazamientoFromJson(String str) =>
    List<CostoDesplazamientoModel>.from(
        json.decode(str).map((x) => CostoDesplazamientoModel.fromJson(x)));

class CostoDesplazamientoModel extends CostoDesplazamientoEntity {
  const CostoDesplazamientoModel({
    int? costoDesplazamientoId,
    String? descripcion,
  }) : super(
          costoDesplazamientoId: costoDesplazamientoId,
          descripcion: descripcion,
        );

  static CostoDesplazamientoModel fromEntity(CostoDesplazamientoEntity entity) {
    return CostoDesplazamientoModel(
      costoDesplazamientoId: entity.costoDesplazamientoId,
      descripcion: entity.descripcion,
    );
  }

  factory CostoDesplazamientoModel.fromJson(Map<String, dynamic> json) =>
      CostoDesplazamientoModel(
        costoDesplazamientoId: json["CostoDesplazamiento_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "CostoDesplazamiento_id": costoDesplazamientoId,
        "Descripcion": descripcion,
      };
}
