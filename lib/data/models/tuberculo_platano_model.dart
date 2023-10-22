import 'dart:convert';

import '../../domain/entities/tuberculo_platano_entity.dart';

List<TuberculoPlatanoModel> tuberculosPlatanosFromJson(String str) =>
    List<TuberculoPlatanoModel>.from(
        json.decode(str).map((x) => TuberculoPlatanoModel.fromJson(x)));

class TuberculoPlatanoModel extends TuberculoPlatanoEntity {
  TuberculoPlatanoModel({
    required int tuberculoPlatanoId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          tuberculoPlatanoId: tuberculoPlatanoId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory TuberculoPlatanoModel.fromJson(Map<String, dynamic> json) =>
      TuberculoPlatanoModel(
        tuberculoPlatanoId: json["TuberculoPlatano_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}

class LstTuberculo {
  int? ubicacionId;
  int? tuberculoPlatanoId;

  LstTuberculo({
    this.ubicacionId,
    this.tuberculoPlatanoId,
  });

  factory LstTuberculo.fromJson(Map<String, dynamic> json) => LstTuberculo(
        tuberculoPlatanoId: json["TuberculoPlatano_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "TuberculoPlatano_id": tuberculoPlatanoId,
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

  UbicacionTuberculosPlatanos({
    this.ubicacionTuberculoPlatanoId,
    this.ubicacionId,
    this.tuberculoPlatanoId,
  });

  factory UbicacionTuberculosPlatanos.fromJson(Map<String, dynamic> json) =>
      UbicacionTuberculosPlatanos(
        ubicacionTuberculoPlatanoId: json["UbicacionTuberculoPlatano_id"],
        ubicacionId: json["Ubicacion_id"],
        tuberculoPlatanoId: json["TuberculoPlatano_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "TuberculoPlatano_id": tuberculoPlatanoId,
      };
}
