import 'dart:convert';

import 'package:ifasoris/domain/entities/metodo_planificacion.dart';

List<MetodoPlanificacionModel> metodosPlanificacionFromJson(String str) =>
    List<MetodoPlanificacionModel>.from(
        json.decode(str).map((x) => MetodoPlanificacionModel.fromJson(x)));

class MetodoPlanificacionModel extends MetodoPlanificacionEntity {
  const MetodoPlanificacionModel({
    int? metodoPlanificacionId,
    String? descripcion,
  }) : super(
          metodoPlanificacionId: metodoPlanificacionId,
          descripcion: descripcion,
        );

  static MetodoPlanificacionModel fromEntity(MetodoPlanificacionEntity entity) {
    return MetodoPlanificacionModel(
      metodoPlanificacionId: entity.metodoPlanificacionId,
      descripcion: entity.descripcion,
    );
  }

  factory MetodoPlanificacionModel.fromJson(Map<String, dynamic> json) =>
      MetodoPlanificacionModel(
        metodoPlanificacionId: json["MetodoPlanificacion_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "MetodoPlanificacion_id": metodoPlanificacionId,
        "Descripcion": descripcion,
      };
}
