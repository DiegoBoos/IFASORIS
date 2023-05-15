import 'dart:convert';

import 'package:ifasoris/domain/entities/resguardo_entity.dart';

List<ResguardoModel> resguardosFromJson(String str) =>
    List<ResguardoModel>.from(
        json.decode(str).map((x) => ResguardoModel.fromJson(x)));

class ResguardoModel extends ResguardoEntity {
  ResguardoModel({
    required int resguardoId,
    required String nombreResguardo,
    required String codaneResguardo,
    required int departamentoIde,
  }) : super(
          resguardoId: resguardoId,
          nombreResguardo: nombreResguardo,
          codaneResguardo: codaneResguardo,
          departamentoIde: departamentoIde,
        );

  factory ResguardoModel.fromJson(Map<String, dynamic> json) => ResguardoModel(
        resguardoId: json["Resguardo_id"],
        nombreResguardo: json["NombreResguardo"],
        codaneResguardo: json["CodaneResguardo"],
        departamentoIde: json["Departamento_Ide"],
      );
}
