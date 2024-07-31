import 'dart:convert';

import '../../domain/entities/techo_vivienda.dart';

List<TechoViviendaModel> techosViviendaFromJson(String str) =>
    List<TechoViviendaModel>.from(
        json.decode(str).map((x) => TechoViviendaModel.fromJson(x)));

class TechoViviendaModel extends TechoViviendaEntity {
  const TechoViviendaModel({
    int? techoViviendaId,
    String? descripcion,
    int? departamentoIde,
  });

  static TechoViviendaModel fromEntity(TechoViviendaEntity entity) {
    return TechoViviendaModel(
      techoViviendaId: entity.techoViviendaId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory TechoViviendaModel.fromJson(Map<String, dynamic> json) =>
      TechoViviendaModel(
        techoViviendaId: json["TechoVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "TechoVivienda_id": techoViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstTecho {
  int? techoViviendaId;
  int? viviendaId;
  String? otroTipoTecho;

  LstTecho({
    this.techoViviendaId,
    this.viviendaId,
    this.otroTipoTecho,
  });

  factory LstTecho.fromJson(Map<String, dynamic> json) => LstTecho(
        viviendaId: json["DatoVivienda_id"],
        techoViviendaId: json["TechoVivienda_id"],
        otroTipoTecho: json["OtroTipoTecho"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": viviendaId,
        "TechoVivienda_id": techoViviendaId,
        "OtroTipoTecho": otroTipoTecho,
      };
}

List<ViviendaTechos> viviendaTechosFromJson(String str) =>
    List<ViviendaTechos>.from(
        json.decode(str).map((x) => ViviendaTechos.fromJson(x)));

class ViviendaTechos {
  int? viviendaTechoId;
  int? datoViviendaId;
  int? techoViviendaId;
  String? otroTipoTecho;

  ViviendaTechos({
    this.viviendaTechoId,
    this.datoViviendaId,
    this.techoViviendaId,
    this.otroTipoTecho,
  });

  factory ViviendaTechos.fromJson(Map<String, dynamic> json) => ViviendaTechos(
        viviendaTechoId: json["ViviendaTecho_id"],
        datoViviendaId: json["DatoVivienda_id"],
        techoViviendaId: json["TechoVivienda_id"],
        otroTipoTecho: json["OtroTipoTecho"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "TechoVivienda_id": techoViviendaId,
        "OtroTipoTecho": otroTipoTecho,
      };
}
