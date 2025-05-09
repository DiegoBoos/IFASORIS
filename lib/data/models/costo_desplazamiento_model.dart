import 'dart:convert';

import '../../domain/entities/costo_desplazamiento_entity.dart';

List<CostoDesplazamientoModel> costosDesplazamientoFromJson(String str) =>
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
        costoDesplazamientoId: json["CostoDesplazamiento_id"],
        descripcion: json["Descripcion"],
      );
}
