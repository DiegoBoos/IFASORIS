import 'dart:convert';

import '../../domain/entities/medio_comunicacion_entity.dart';

List<MedioComunicacionModel> mediosComunicacionModelFromJson(String str) =>
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
        medioComunicacionId: json["medioComunicacion_id"],
        descripcion: json["descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "medioComunicacion_id": medioComunicacionId,
        "descripcion": descripcion,
      };
}
