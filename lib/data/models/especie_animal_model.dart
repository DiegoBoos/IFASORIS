import 'dart:convert';

import '../../domain/entities/especie_animal_entity.dart';

List<EspecieAnimalModel> especiesAnimalesFromJson(String str) =>
    List<EspecieAnimalModel>.from(
        json.decode(str).map((x) => EspecieAnimalModel.fromJson(x)));

class EspecieAnimalModel extends EspecieAnimalEntity {
  EspecieAnimalModel({
    required int especieAnimalCriaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          especieAnimalCriaId: especieAnimalCriaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory EspecieAnimalModel.fromJson(Map<String, dynamic> json) =>
      EspecieAnimalModel(
        especieAnimalCriaId: json["EspecieAnimalCria_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}

class LstAnimalCria {
  int? especieAnimalCriaId;

  LstAnimalCria({
    this.especieAnimalCriaId,
  });

  factory LstAnimalCria.fromJson(Map<String, dynamic> json) => LstAnimalCria(
        especieAnimalCriaId: json["EspecieAnimalCria_id"],
      );

  Map<String, dynamic> toJson() => {
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
