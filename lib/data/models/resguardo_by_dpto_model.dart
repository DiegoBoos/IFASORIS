import 'dart:convert';

import 'package:ifasoris/domain/entities/resguardo_by_dpto_entity.dart';

List<ResguardoByDptoModel> resguardosByDptoModelFromJson(String str) =>
    List<ResguardoByDptoModel>.from(
        json.decode(str).map((x) => ResguardoByDptoModel.fromJson(x)));

class ResguardoByDptoModel extends ResguardoByDptoEntity {
  ResguardoByDptoModel({
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

  factory ResguardoByDptoModel.fromJson(Map<String, dynamic> json) =>
      ResguardoByDptoModel(
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
