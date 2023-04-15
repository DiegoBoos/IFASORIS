import 'dart:convert';

import '../../domain/entities/especie_animal_entity.dart';

List<EspecieAnimalModel> especiesAnimalesModelFromJson(String str) =>
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
