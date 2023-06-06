import 'dart:convert';

import 'package:ifasoris/domain/entities/fruto_entity.dart';

List<FrutoModel> frutosFromJson(String str) =>
    List<FrutoModel>.from(json.decode(str).map((x) => FrutoModel.fromJson(x)));

class FrutoModel extends FrutoEntity {
  FrutoModel({
    required int frutoId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          frutoId: frutoId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory FrutoModel.fromJson(Map<String, dynamic> json) => FrutoModel(
        frutoId: json["Fruto_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}

class LstFruto {
  int? frutoId;

  LstFruto({
    this.frutoId,
  });

  factory LstFruto.fromJson(Map<String, dynamic> json) => LstFruto(
        frutoId: json["Fruto_id"],
      );

  Map<String, dynamic> toJson() => {
        "Fruto_id": frutoId,
      };
}

List<UbicacionFrutos> ubicacionFrutosFromJson(String str) =>
    List<UbicacionFrutos>.from(
        json.decode(str).map((x) => UbicacionFrutos.fromJson(x)));

class UbicacionFrutos {
  int? ubicacionFrutoId;
  int? ubicacionId;
  int? frutoId;

  UbicacionFrutos({
    this.ubicacionFrutoId,
    this.ubicacionId,
    this.frutoId,
  });

  factory UbicacionFrutos.fromJson(Map<String, dynamic> json) =>
      UbicacionFrutos(
        ubicacionFrutoId: json["UbicacionFruto_id"],
        ubicacionId: json["Ubicacion_id"],
        frutoId: json["Fruto_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Fruto_id": frutoId,
      };
}
