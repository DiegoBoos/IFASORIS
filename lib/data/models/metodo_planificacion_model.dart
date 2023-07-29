import 'dart:convert';

import 'package:ifasoris/domain/entities/metodo_planificacion_entity.dart';

List<MetodoPlanificacionModel> metodosPlanificacionFromJson(String str) =>
    List<MetodoPlanificacionModel>.from(
        json.decode(str).map((x) => MetodoPlanificacionModel.fromJson(x)));

class MetodoPlanificacionModel extends MetodoPlanificacionEntity {
  MetodoPlanificacionModel({
    required int metodoPlanificacionId,
    required String descripcion,
  }) : super(
            metodoPlanificacionId: metodoPlanificacionId,
            descripcion: descripcion);

  factory MetodoPlanificacionModel.fromJson(Map<String, dynamic> json) =>
      MetodoPlanificacionModel(
        metodoPlanificacionId: json["MetodoPlanificacion_id"],
        descripcion: json["Descripcion"],
      );
}
