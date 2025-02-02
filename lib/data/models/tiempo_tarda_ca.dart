import 'dart:convert';

import '../../domain/entities/tiempo_tarda_ca.dart';

List<TiempoTardaCAModel> tiemposTardaCAFromJson(String str) =>
    List<TiempoTardaCAModel>.from(
        json.decode(str).map((x) => TiempoTardaCAModel.fromJson(x)));

class TiempoTardaCAModel extends TiempoTardaCAEntity {
  const TiempoTardaCAModel({
    super.tiempoTardaId,
    super.descripcion,
  });

  factory TiempoTardaCAModel.fromEntity(TiempoTardaCAEntity entity) {
    return TiempoTardaCAModel(
      tiempoTardaId: entity.tiempoTardaId,
      descripcion: entity.descripcion,
    );
  }

  factory TiempoTardaCAModel.fromJson(Map<String, dynamic> json) =>
      TiempoTardaCAModel(
        tiempoTardaId: json["TiempoTarda_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "TiempoTarda_id": tiempoTardaId,
        "Descripcion": descripcion,
      };
}
