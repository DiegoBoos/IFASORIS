import 'dart:convert';

import '../../domain/entities/tuberculo_platano_entity.dart';

List<TuberculoPlatanoModel> tuberculosPlatanosModelFromJson(String str) =>
    List<TuberculoPlatanoModel>.from(
        json.decode(str).map((x) => TuberculoPlatanoModel.fromJson(x)));

class TuberculoPlatanoModel extends TuberculoPlatanoEntity {
  TuberculoPlatanoModel({
    required int tuberculoPlatanoId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          tuberculoPlatanoId: tuberculoPlatanoId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory TuberculoPlatanoModel.fromJson(Map<String, dynamic> json) =>
      TuberculoPlatanoModel(
        tuberculoPlatanoId: json["tuberculoPlatano_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "tuberculoPlatano_id": tuberculoPlatanoId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
