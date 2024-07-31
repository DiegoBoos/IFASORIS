import 'dart:convert';

import '../../domain/entities/ventilacion_vivienda.dart';

List<VentilacionViviendaModel> ventilacionesViviendaFromJson(String str) =>
    List<VentilacionViviendaModel>.from(
        json.decode(str).map((x) => VentilacionViviendaModel.fromJson(x)));

class VentilacionViviendaModel extends VentilacionViviendaEntity {
  const VentilacionViviendaModel({
    int? ventilacionViviendaId,
    String? descripcion,
  });

  static VentilacionViviendaModel fromEntity(VentilacionViviendaEntity entity) {
    return VentilacionViviendaModel(
      ventilacionViviendaId: entity.ventilacionViviendaId,
      descripcion: entity.descripcion,
    );
  }

  factory VentilacionViviendaModel.fromJson(Map<String, dynamic> json) =>
      VentilacionViviendaModel(
        ventilacionViviendaId: json["VentilacionVivienda_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "VentilacionVivienda_id": ventilacionViviendaId,
        "Descripcion": descripcion,
      };
}
