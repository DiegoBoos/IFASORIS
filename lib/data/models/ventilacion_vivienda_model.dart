import 'dart:convert';

import '../../domain/entities/ventilacion_vivienda_entity.dart';

List<VentilacionViviendaModel> ventilacionesViviendaFromJson(String str) =>
    List<VentilacionViviendaModel>.from(
        json.decode(str).map((x) => VentilacionViviendaModel.fromJson(x)));

class VentilacionViviendaModel extends VentilacionViviendaEntity {
  VentilacionViviendaModel({
    required int ventilacionViviendaId,
    required String descripcion,
  }) : super(
            ventilacionViviendaId: ventilacionViviendaId,
            descripcion: descripcion);

  factory VentilacionViviendaModel.fromJson(Map<String, dynamic> json) =>
      VentilacionViviendaModel(
        ventilacionViviendaId: json["VentilacionVivienda_id"],
        descripcion: json["Descripcion"],
      );
}
