import 'dart:convert';

import 'package:ifasoris/domain/entities/dificultad_acceso_ca_entity.dart';

List<DificultadAccesoCAModel> dificultadesAccesoCAModelFromJson(String str) =>
    List<DificultadAccesoCAModel>.from(
        json.decode(str).map((x) => DificultadAccesoCAModel.fromJson(x)));

class DificultadAccesoCAModel extends DificultadAccesoCAEntity {
  DificultadAccesoCAModel({
    required int dificultaAccesoId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          dificultaAccesoId: dificultaAccesoId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory DificultadAccesoCAModel.fromJson(Map<String, dynamic> json) =>
      DificultadAccesoCAModel(
        dificultaAccesoId: json["dificultaAcceso_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "dificultaAcceso_id": dificultaAccesoId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
