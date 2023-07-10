// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import '../../domain/entities/pueblo_indigena_entity.dart';

List<PuebloIndigenaModel> pueblosIndigenasFromJson(String str) =>
    List<PuebloIndigenaModel>.from(
        json.decode(str).map((x) => PuebloIndigenaModel.fromJson(x)));

class PuebloIndigenaModel extends PuebloIndigenaEntity {
  PuebloIndigenaModel({
    required int puebloIde,
    required String TPS_CMD_IND_RSG_ID,
    required String TPS_CMD_IND_RSG_NOMBRE,
  }) : super(
          puebloIde: puebloIde,
          TPS_CMD_IND_RSG_ID: TPS_CMD_IND_RSG_ID,
          TPS_CMD_IND_RSG_NOMBRE: TPS_CMD_IND_RSG_NOMBRE,
        );

  factory PuebloIndigenaModel.fromJson(Map<String, dynamic> json) =>
      PuebloIndigenaModel(
        puebloIde: json["Pueblo_ide"],
        TPS_CMD_IND_RSG_ID: json["TPS_CMD_IND_RSG_ID"],
        TPS_CMD_IND_RSG_NOMBRE: json["TPS_CMD_IND_RSG_NOMBRE"],
      );
}
