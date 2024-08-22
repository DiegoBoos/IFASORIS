import 'dart:convert';

import '../../domain/entities/especie_animal.dart';

List<EspecieAnimalModel> especiesAnimalesFromJson(String str) =>
    List<EspecieAnimalModel>.from(
        json.decode(str).map((x) => EspecieAnimalModel.fromJson(x)));

class EspecieAnimalModel extends EspecieAnimalEntity {
  const EspecieAnimalModel({
    int? especieAnimalCriaId,
    String? descripcion,
    int? departamentoIde,
  }) : super(
          especieAnimalCriaId: especieAnimalCriaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  static EspecieAnimalModel fromEntity(EspecieAnimalEntity entity) {
    return EspecieAnimalModel(
      especieAnimalCriaId: entity.especieAnimalCriaId,
      descripcion: entity.descripcion,
      departamentoIde: entity.departamentoIde,
    );
  }

  factory EspecieAnimalModel.fromJson(Map<String, dynamic> json) =>
      EspecieAnimalModel(
        especieAnimalCriaId: json["EspecieAnimalCria_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "EspecieAnimalCria_id": especieAnimalCriaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}

class LstAnimalCria {
  int? ubicacionId;
  int? especieAnimalCriaId;

  LstAnimalCria({
    this.ubicacionId,
    this.especieAnimalCriaId,
  });

  factory LstAnimalCria.fromJson(Map<String, dynamic> json) => LstAnimalCria(
        especieAnimalCriaId: json["EspecieAnimalCria_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "EspecieAnimalCria_id": especieAnimalCriaId,
      };
}

List<UbicacionEspecieAnimalesCria> ubicacionEspecieAnimalesCriaFromJson(
        String str) =>
    List<UbicacionEspecieAnimalesCria>.from(
        json.decode(str).map((x) => UbicacionEspecieAnimalesCria.fromJson(x)));

class UbicacionEspecieAnimalesCria {
  int? ubicacionEspecieAnimalId;
  int? ubicacionId;
  int? especieAnimalCriaId;

  UbicacionEspecieAnimalesCria({
    this.ubicacionEspecieAnimalId,
    this.ubicacionId,
    this.especieAnimalCriaId,
  });

  factory UbicacionEspecieAnimalesCria.fromJson(Map<String, dynamic> json) =>
      UbicacionEspecieAnimalesCria(
        ubicacionEspecieAnimalId: json["UbicacionEspecieAnimal_id"],
        ubicacionId: json["Ubicacion_id"],
        especieAnimalCriaId: json["EspecieAnimalCria_id"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "EspecieAnimalCria_id": especieAnimalCriaId,
      };
}
