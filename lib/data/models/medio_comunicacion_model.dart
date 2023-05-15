import 'dart:convert';

import '../../domain/entities/medio_comunicacion_entity.dart';

List<MedioComunicacionModel> mediosComunicacionFromJson(String str) =>
    List<MedioComunicacionModel>.from(
        json.decode(str).map((x) => MedioComunicacionModel.fromJson(x)));

class MedioComunicacionModel extends MedioComunicacionEntity {
  MedioComunicacionModel({
    required int medioComunicacionId,
    required String descripcion,
  }) : super(
            medioComunicacionId: medioComunicacionId, descripcion: descripcion);

  factory MedioComunicacionModel.fromJson(Map<String, dynamic> json) =>
      MedioComunicacionModel(
        medioComunicacionId: json["MedioComunicacion_id"],
        descripcion: json["Descripcion"],
      );
}
