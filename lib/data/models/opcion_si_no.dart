import 'dart:convert';

import '../../domain/entities/opcion_si_no.dart';

List<OpcionSiNoModel> opcionesSiNoFromJson(String str) =>
    List<OpcionSiNoModel>.from(
        json.decode(str).map((x) => OpcionSiNoModel.fromJson(x)));

class OpcionSiNoModel extends OpcionSiNoEntity {
  const OpcionSiNoModel({
    super.opcionId,
    super.descripcion,
  });

  factory OpcionSiNoModel.fromEntity(OpcionSiNoEntity entity) {
    return OpcionSiNoModel(
      opcionId: entity.opcionId,
      descripcion: entity.descripcion,
    );
  }

  factory OpcionSiNoModel.fromJson(Map<String, dynamic> json) =>
      OpcionSiNoModel(
        opcionId: json["Opcion_id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Opcion_id": opcionId,
        "Descripcion": descripcion,
      };
}
