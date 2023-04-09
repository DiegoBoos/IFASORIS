import 'dart:convert';

import '../../domain/entities/opcion_si_no_entity.dart';

List<OpcionSiNoModel> opcionesSiNoModelFromJson(String str) =>
    List<OpcionSiNoModel>.from(
        json.decode(str).map((x) => OpcionSiNoModel.fromJson(x)));

class OpcionSiNoModel extends OpcionSiNoEntity {
  OpcionSiNoModel({
    required int opcionId,
    required String descripcion,
  }) : super(opcionId: opcionId, descripcion: descripcion);

  factory OpcionSiNoModel.fromJson(Map<String, dynamic> json) =>
      OpcionSiNoModel(
        opcionId: json["opcion_id"],
        descripcion: json["descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "opcion_id": opcionId,
        "descripcion": descripcion,
      };
}
