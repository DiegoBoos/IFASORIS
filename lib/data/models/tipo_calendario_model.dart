import 'dart:convert';

import '../../domain/entities/tipo_calendario_entity.dart';

List<TipoCalendarioModel> tiposCalendarioFromJson(String str) =>
    List<TipoCalendarioModel>.from(
        json.decode(str).map((x) => TipoCalendarioModel.fromJson(x)));

class TipoCalendarioModel extends TipoCalendarioEntity {
  TipoCalendarioModel({
    required int tipoCalendarioId,
    required String descripcion,
  }) : super(
          tipoCalendarioId: tipoCalendarioId,
          descripcion: descripcion,
        );

  factory TipoCalendarioModel.fromJson(Map<String, dynamic> json) =>
      TipoCalendarioModel(
        tipoCalendarioId: json["TipoCalendario_id"],
        descripcion: json["Descripcion"],
      );
}
