import 'dart:convert';

import '../../domain/entities/opcion_si_no_entity.dart';

List<OpcionSiNoModel> opcionesSiNoFromJson(String str) =>
    List<OpcionSiNoModel>.from(
        json.decode(str).map((x) => OpcionSiNoModel.fromJson(x)));

class OpcionSiNoModel extends OpcionSiNoEntity {
  OpcionSiNoModel({
    required int opcionId,
    required String descripcion,
  }) : super(opcionId: opcionId, descripcion: descripcion);

  factory OpcionSiNoModel.fromJson(Map<String, dynamic> json) =>
      OpcionSiNoModel(
        opcionId: json["Opcion_id"],
        descripcion: json["Descripcion"],
      );
}
