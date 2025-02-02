import 'dart:convert';

import '../../domain/entities/tipo_calendario.dart';

List<TipoCalendarioModel> tiposCalendarioFromJson(String str) =>
    List<TipoCalendarioModel>.from(
        json.decode(str).map((x) => TipoCalendarioModel.fromJson(x)));

class TipoCalendarioModel extends TipoCalendarioEntity {
  const TipoCalendarioModel({
    super.tipoCalendarioId,
    super.descripcion,
  });

  factory TipoCalendarioModel.fromEntity(TipoCalendarioEntity entity) {
    return TipoCalendarioModel(
      tipoCalendarioId: entity.tipoCalendarioId,
      descripcion: entity.descripcion,
    );
  }

  factory TipoCalendarioModel.fromJson(Map<String, dynamic> json) =>
      TipoCalendarioModel(
        tipoCalendarioId: json["TipoCalendario_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "TipoCalendario_id": tipoCalendarioId,
        "Descripcion": descripcion,
      };
}
