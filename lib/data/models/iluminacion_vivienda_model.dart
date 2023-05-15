import 'dart:convert';

import '../../domain/entities/iluminacion_vivienda_entity.dart';

List<IluminacionViviendaModel> iluminacionesViviendaFromJson(String str) =>
    List<IluminacionViviendaModel>.from(
        json.decode(str).map((x) => IluminacionViviendaModel.fromJson(x)));

class IluminacionViviendaModel extends IluminacionViviendaEntity {
  IluminacionViviendaModel({
    required int iluminacionViviendaId,
    required String descripcion,
  }) : super(
            iluminacionViviendaId: iluminacionViviendaId,
            descripcion: descripcion);

  factory IluminacionViviendaModel.fromJson(Map<String, dynamic> json) =>
      IluminacionViviendaModel(
        iluminacionViviendaId: json["IluminacionVivienda_id"],
        descripcion: json["Descripcion"],
      );
}
