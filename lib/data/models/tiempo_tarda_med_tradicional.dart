import 'dart:convert';

import '../../domain/entities/tiempo_tarda_med_tradicional.dart';

List<TiempoTardaMedTradicionalModel> tiemposTardaMedTradicionalFromJson(
        String str) =>
    List<TiempoTardaMedTradicionalModel>.from(json
        .decode(str)
        .map((x) => TiempoTardaMedTradicionalModel.fromJson(x)));

class TiempoTardaMedTradicionalModel extends TiempoTardaMedTradicionalEntity {
  const TiempoTardaMedTradicionalModel({
    super.tiempoTardaMedTradId,
    super.descripcion,
  });

  factory TiempoTardaMedTradicionalModel.fromEntity(
      TiempoTardaMedTradicionalEntity entity) {
    return TiempoTardaMedTradicionalModel(
      tiempoTardaMedTradId: entity.tiempoTardaMedTradId,
      descripcion: entity.descripcion,
    );
  }

  factory TiempoTardaMedTradicionalModel.fromJson(Map<String, dynamic> json) =>
      TiempoTardaMedTradicionalModel(
        tiempoTardaMedTradId: json["TiempoTardaMedTrad_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "TiempoTardaMedTrad_id": tiempoTardaMedTradId,
        "Descripcion": descripcion,
      };
}
