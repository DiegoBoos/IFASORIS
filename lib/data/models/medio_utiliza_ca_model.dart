import 'dart:convert';

import '../../domain/entities/medio_utiliza_ca_entity.dart';

List<MedioUtilizaCAModel> mediosUtilizaCAFromJson(String str) =>
    List<MedioUtilizaCAModel>.from(
        json.decode(str).map((x) => MedioUtilizaCAModel.fromJson(x)));

class MedioUtilizaCAModel extends MedioUtilizaCAEntity {
  MedioUtilizaCAModel({
    required int medioUtilizaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          medioUtilizaId: medioUtilizaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory MedioUtilizaCAModel.fromJson(Map<String, dynamic> json) =>
      MedioUtilizaCAModel(
        medioUtilizaId: json["MedioUtiliza_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}

class LstMediosUtilizaCA {
  int? ubicacionId;
  int? medioUtilizaId;

  LstMediosUtilizaCA({
    this.ubicacionId,
    this.medioUtilizaId,
  });

  factory LstMediosUtilizaCA.fromJson(Map<String, dynamic> json) =>
      LstMediosUtilizaCA(
        medioUtilizaId: json["MedioUtiliza_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "MedioUtiliza_id": medioUtilizaId,
      };
}

List<UbicacionMediosUtilizaCA> ubicacionMediosCAFromJson(String str) =>
    List<UbicacionMediosUtilizaCA>.from(
        json.decode(str).map((x) => UbicacionMediosUtilizaCA.fromJson(x)));

class UbicacionMediosUtilizaCA {
  int? ubicacionMedioCAId;
  int? ubicacionId;
  int? medioUtilizaId;

  UbicacionMediosUtilizaCA({
    this.ubicacionMedioCAId,
    this.ubicacionId,
    this.medioUtilizaId,
  });

  factory UbicacionMediosUtilizaCA.fromJson(Map<String, dynamic> json) =>
      UbicacionMediosUtilizaCA(
        ubicacionMedioCAId: json["UbicacionMediosCentroAtencion_id"],
        ubicacionId: json["Ubicacion_id"],
        medioUtilizaId: json["MedioUtiliza_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "MedioUtiliza_id": medioUtilizaId,
      };
}
