import 'dart:convert';

import '../../domain/entities/techo_vivienda_entity.dart';

List<TechoViviendaModel> techosViviendaFromJson(String str) =>
    List<TechoViviendaModel>.from(
        json.decode(str).map((x) => TechoViviendaModel.fromJson(x)));

class TechoViviendaModel extends TechoViviendaEntity {
  TechoViviendaModel({
    required int techoViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          techoViviendaId: techoViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory TechoViviendaModel.fromJson(Map<String, dynamic> json) =>
      TechoViviendaModel(
        techoViviendaId: json["TechoVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
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
