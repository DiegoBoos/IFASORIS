import 'dart:convert';

import '../../domain/entities/tuberculo_platano.dart';

List<TuberculoPlatanoModel> tuberculosPlatanosFromJson(String str) =>
    List<TuberculoPlatanoModel>.from(
        json.decode(str).map((x) => TuberculoPlatanoModel.fromJson(x)));

class TuberculoPlatanoModel extends TuberculoPlatanoEntity {
  const TuberculoPlatanoModel({
    int? tuberculoPlatanoId,
    String? descripcion,
    int? departamentoIde,
  });

  static TuberculoPlatanoModel fromEntity(TuberculoPlatanoEntity entity) {
    return TuberculoPlatanoModel(
      tuberculoPlatanoId: entity.tuberculoPlatanoId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory TuberculoPlatanoModel.fromJson(Map<String, dynamic> json) =>
      TuberculoPlatanoModel(
        tuberculoPlatanoId: json["TuberculoPlatano_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "TuberculoPlatano_id": tuberculoPlatanoId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstTuberculo {
  int? ubicacionId;
  int? tuberculoPlatanoId;
  String? otroTuberculoPlatano;

  LstTuberculo({
    this.ubicacionId,
    this.tuberculoPlatanoId,
    this.otroTuberculoPlatano,
  });

  factory LstTuberculo.fromJson(Map<String, dynamic> json) => LstTuberculo(
        tuberculoPlatanoId: json["TuberculoPlatano_id"],
        otroTuberculoPlatano: json["OtroTuberculoPlatano"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "TuberculoPlatano_id": tuberculoPlatanoId,
        "OtroTuberculoPlatano": otroTuberculoPlatano,
      };
}

List<UbicacionTuberculosPlatanos> ubicacionTuberculosPlatanosFromJson(
        String str) =>
    List<UbicacionTuberculosPlatanos>.from(
        json.decode(str).map((x) => UbicacionTuberculosPlatanos.fromJson(x)));

class UbicacionTuberculosPlatanos {
  int? ubicacionTuberculoPlatanoId;
  int? ubicacionId;
  int? tuberculoPlatanoId;
  String? otroTuberculoPlatano;

  UbicacionTuberculosPlatanos({
    this.ubicacionTuberculoPlatanoId,
    this.ubicacionId,
    this.tuberculoPlatanoId,
    this.otroTuberculoPlatano,
  });

  factory UbicacionTuberculosPlatanos.fromJson(Map<String, dynamic> json) =>
      UbicacionTuberculosPlatanos(
        ubicacionTuberculoPlatanoId: json["UbicacionTuberculoPlatano_id"],
        ubicacionId: json["Ubicacion_id"],
        tuberculoPlatanoId: json["TuberculoPlatano_id"],
        otroTuberculoPlatano: json["OtroTuberculoPlatano"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "TuberculoPlatano_id": tuberculoPlatanoId,
        "OtroTuberculoPlatano": otroTuberculoPlatano,
      };
}
