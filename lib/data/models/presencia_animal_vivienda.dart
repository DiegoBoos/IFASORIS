import 'dart:convert';

import '../../domain/entities/presencia_animal_vivienda.dart';

List<PresenciaAnimalViviendaModel> presenciaAnimalesViviendaFromJson(
        String str) =>
    List<PresenciaAnimalViviendaModel>.from(
        json.decode(str).map((x) => PresenciaAnimalViviendaModel.fromJson(x)));

class PresenciaAnimalViviendaModel extends PresenciaAnimalViviendaEntity {
  const PresenciaAnimalViviendaModel({
    int? presenciaAnimalViviendaId,
    String? descripcion,
    int? departamentoIde,
  });

  static PresenciaAnimalViviendaModel fromEntity(
      PresenciaAnimalViviendaEntity entity) {
    return PresenciaAnimalViviendaModel(
      presenciaAnimalViviendaId: entity.presenciaAnimalViviendaId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory PresenciaAnimalViviendaModel.fromJson(Map<String, dynamic> json) =>
      PresenciaAnimalViviendaModel(
        presenciaAnimalViviendaId: json["PresenciaAnimalVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "PresenciaAnimalVivienda_id": presenciaAnimalViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstPresenciaAnimal {
  int? viviendaId;
  int? presenciaAnimalViviendaId;
  String? otroPresenciaAnimal;

  LstPresenciaAnimal({
    this.viviendaId,
    this.presenciaAnimalViviendaId,
    this.otroPresenciaAnimal,
  });

  factory LstPresenciaAnimal.fromJson(Map<String, dynamic> json) =>
      LstPresenciaAnimal(
        presenciaAnimalViviendaId: json["PresenciaAnimalVivienda_id"],
        otroPresenciaAnimal: json["OtroPresenciaAnimal"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": viviendaId,
        "PresenciaAnimalVivienda_id": presenciaAnimalViviendaId,
        "OtroPresenciaAnimal": otroPresenciaAnimal,
      };
}

List<ViviendaPresenciaAnimales> viviendaPresenciaAnimalesFromJson(String str) =>
    List<ViviendaPresenciaAnimales>.from(
        json.decode(str).map((x) => ViviendaPresenciaAnimales.fromJson(x)));

class ViviendaPresenciaAnimales {
  int? viviendaPresenciaAnimalId;
  int? datoViviendaId;
  int? presenciaAnimalViviendaId;
  String? otroPresenciaAnimal;

  ViviendaPresenciaAnimales({
    this.viviendaPresenciaAnimalId,
    this.datoViviendaId,
    this.presenciaAnimalViviendaId,
    this.otroPresenciaAnimal,
  });

  factory ViviendaPresenciaAnimales.fromJson(Map<String, dynamic> json) =>
      ViviendaPresenciaAnimales(
        viviendaPresenciaAnimalId: json["ViviendaPresenciaAnimal_id"],
        datoViviendaId: json["DatoVivienda_id"],
        presenciaAnimalViviendaId: json["PresenciaAnimalVivienda_id"],
        otroPresenciaAnimal: json["OtroPresenciaAnimal"],
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": datoViviendaId,
        "PresenciaAnimalVivienda_id": presenciaAnimalViviendaId,
        "OtroPresenciaAnimal": otroPresenciaAnimal,
      };
}
