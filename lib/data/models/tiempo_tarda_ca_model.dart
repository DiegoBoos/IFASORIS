import 'dart:convert';

import '../../domain/entities/tiempo_tarda_ca_entity.dart';

List<TiempoTardaCAModel> tiemposTardaCAModelFromJson(String str) =>
    List<TiempoTardaCAModel>.from(
        json.decode(str).map((x) => TiempoTardaCAModel.fromJson(x)));

class TiempoTardaCAModel extends TiempoTardaCAEntity {
  TiempoTardaCAModel({
    required int tiempoTardaId,
    required String descripcion,
  }) : super(tiempoTardaId: tiempoTardaId, descripcion: descripcion);

  factory TiempoTardaCAModel.fromJson(Map<String, dynamic> json) =>
      TiempoTardaCAModel(
        tiempoTardaId: json["tiempoTarda_id"],
        descripcion: json["descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "tiempoTarda_id": tiempoTardaId,
        "descripcion": descripcion,
      };
}
