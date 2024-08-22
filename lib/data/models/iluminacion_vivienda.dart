import 'dart:convert';

import '../../domain/entities/iluminacion_vivienda.dart';

List<IluminacionViviendaModel> iluminacionesViviendaFromJson(String str) =>
    List<IluminacionViviendaModel>.from(
        json.decode(str).map((x) => IluminacionViviendaModel.fromJson(x)));

class IluminacionViviendaModel extends IluminacionViviendaEntity {
  const IluminacionViviendaModel({
    int? iluminacionViviendaId,
    String? descripcion,
  }) : super(
          iluminacionViviendaId: iluminacionViviendaId,
          descripcion: descripcion,
        );

  static IluminacionViviendaModel fromEntity(IluminacionViviendaEntity entity) {
    return IluminacionViviendaModel(
      iluminacionViviendaId: entity.iluminacionViviendaId,
      descripcion: entity.descripcion,
    );
  }

  factory IluminacionViviendaModel.fromJson(Map<String, dynamic> json) =>
      IluminacionViviendaModel(
        iluminacionViviendaId: json["IluminacionVivienda_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "IluminacionVivienda_id": iluminacionViviendaId,
        "Descripcion": descripcion,
      };
}
