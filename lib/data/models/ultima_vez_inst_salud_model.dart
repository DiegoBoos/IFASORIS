import 'dart:convert';

import 'package:ifasoris/domain/entities/ultima_vez_inst_salud_entity.dart';

List<UltimaVezInstSaludModel> ultimasVecesInstSaludFromJson(String str) =>
    List<UltimaVezInstSaludModel>.from(
        json.decode(str).map((x) => UltimaVezInstSaludModel.fromJson(x)));

class UltimaVezInstSaludModel extends UltimaVezInstSaludEntity {
  UltimaVezInstSaludModel({
    required int ultimaVezInstSaludId,
    required String descripcion,
  }) : super(
            ultimaVezInstSaludId: ultimaVezInstSaludId,
            descripcion: descripcion);

  factory UltimaVezInstSaludModel.fromJson(Map<String, dynamic> json) =>
      UltimaVezInstSaludModel(
        ultimaVezInstSaludId: json["UltimaVezInstSalud_id"],
        descripcion: json["Descripcion"],
      );
}
