import 'dart:convert';

import '../../domain/entities/tiempo_tarda_med_tradicional_entity.dart';

List<TiempoTardaMedTradicionalModel> tiemposTardaMedTradicionalFromJson(
        String str) =>
    List<TiempoTardaMedTradicionalModel>.from(json
        .decode(str)
        .map((x) => TiempoTardaMedTradicionalModel.fromJson(x)));

class TiempoTardaMedTradicionalModel extends TiempoTardaMedTradicionalEntity {
  TiempoTardaMedTradicionalModel({
    required int tiempoTardaMedTradId,
    required String descripcion,
  }) : super(
            tiempoTardaMedTradId: tiempoTardaMedTradId,
            descripcion: descripcion);

  factory TiempoTardaMedTradicionalModel.fromJson(Map<String, dynamic> json) =>
      TiempoTardaMedTradicionalModel(
        tiempoTardaMedTradId: json["TiempoTardaMedTrad_id"],
        descripcion: json["Descripcion"],
      );
}
