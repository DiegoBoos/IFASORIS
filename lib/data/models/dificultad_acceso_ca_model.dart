import 'dart:convert';

import 'package:ifasoris/domain/entities/dificultad_acceso_ca_entity.dart';

List<DificultadAccesoCAModel> dificultadesAccesoCAFromJson(String str) =>
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
        dificultaAccesoId: json["DificultaAcceso_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
