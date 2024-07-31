import 'dart:convert';

import 'package:ifasoris/domain/entities/resguardo.dart';

List<ResguardoModel> resguardosFromJson(String str) =>
    List<ResguardoModel>.from(
        json.decode(str).map((x) => ResguardoModel.fromJson(x)));

class ResguardoModel extends ResguardoEntity {
  const ResguardoModel({
    int? resguardoId,
    String? nombreResguardo,
    String? codaneResguardo,
    int? departamentoIde,
  });

  static ResguardoModel fromEntity(ResguardoEntity entity) {
    return ResguardoModel(
      resguardoId: entity.resguardoId,
      nombreResguardo: entity.nombreResguardo,
      codaneResguardo: entity.codaneResguardo,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory ResguardoModel.fromJson(Map<String, dynamic> json) => ResguardoModel(
        resguardoId: json["Resguardo_id"],
        nombreResguardo: json["NombreResguardo"],
        codaneResguardo: json["CodaneResguardo"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "Resguardo_id": resguardoId,
        "NombreResguardo": nombreResguardo,
        "CodaneResguardo": codaneResguardo,
        "Departamento_Ide": departamentoIde,
      };
}
