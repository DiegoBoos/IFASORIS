import 'dart:convert';

import '../../domain/entities/medio_comunicacion.dart';

List<MedioComunicacionModel> mediosComunicacionFromJson(String str) =>
    List<MedioComunicacionModel>.from(
        json.decode(str).map((x) => MedioComunicacionModel.fromJson(x)));

class MedioComunicacionModel extends MedioComunicacionEntity {
  const MedioComunicacionModel({
    int? medioComunicacionId,
    String? descripcion,
    int? departamentoId,
  }) : super(
          medioComunicacionId: medioComunicacionId,
          descripcion: descripcion,
          departamentoId: departamentoId,
        );

  static MedioComunicacionModel fromEntity(MedioComunicacionEntity entity) {
    return MedioComunicacionModel(
      medioComunicacionId: entity.medioComunicacionId,
      descripcion: entity.descripcion,
      departamentoId: entity.departamentoId,
    );
  }

  factory MedioComunicacionModel.fromJson(Map<String, dynamic> json) =>
      MedioComunicacionModel(
        medioComunicacionId: json["MedioComunicacion_id"],
        descripcion: json["Descripcion"],
        departamentoId: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "MedioComunicacion_id": medioComunicacionId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoId
      };
}

class LstMediosComunica {
  int? ubicacionId;
  int? medioComunicacionId;

  LstMediosComunica({
    this.ubicacionId,
    this.medioComunicacionId,
  });

  factory LstMediosComunica.fromJson(Map<String, dynamic> json) =>
      LstMediosComunica(
        medioComunicacionId: json["MedioComunicacion_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "MedioComunicacion_id": medioComunicacionId,
      };
}

List<UbicacionMediosComunicacion> ubicacionMediosComunicacionFromJson(
        String str) =>
    List<UbicacionMediosComunicacion>.from(
        json.decode(str).map((x) => UbicacionMediosComunicacion.fromJson(x)));

class UbicacionMediosComunicacion {
  int? ubicacionMedioId;
  int? ubicacionId;
  int? medioComunicacionId;

  UbicacionMediosComunicacion({
    this.ubicacionMedioId,
    this.ubicacionId,
    this.medioComunicacionId,
  });

  factory UbicacionMediosComunicacion.fromJson(Map<String, dynamic> json) =>
      UbicacionMediosComunicacion(
        ubicacionMedioId: json["UbicacionMedio_id"],
        ubicacionId: json["Ubicacion_id"],
        medioComunicacionId: json["MedioComunicacion_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "MedioComunicacion_id": medioComunicacionId,
      };
}
