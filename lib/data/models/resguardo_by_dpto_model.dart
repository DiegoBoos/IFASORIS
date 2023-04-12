import 'dart:convert';

import 'package:ifasoris/domain/entities/resguardo_entity.dart';

List<ResguardoModel> resguardosByDptoModelFromJson(String str) =>
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
        resguardoId: json["resguardo_id"],
        nombreResguardo: json["nombreResguardo"],
        codaneResguardo: json["codaneResguardo"],
        departamentoIde: json["departamento_Ide"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "resguardo_id": resguardoId,
        "nombreResguardo": nombreResguardo,
        "codaneResguardo": codaneResguardo,
        "departamento_Ide": departamentoIde,
      };
}
