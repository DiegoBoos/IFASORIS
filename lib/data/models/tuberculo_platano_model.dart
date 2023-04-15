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
        tuberculoPlatanoId: json["TuberculoPlatano_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
