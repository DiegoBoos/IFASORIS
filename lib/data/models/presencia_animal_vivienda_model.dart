import 'dart:convert';

import '../../domain/entities/presencia_animal_vivienda_entity.dart';

List<PresenciaAnimalViviendaModel> presenciaAnimalesViviendaFromJson(
        String str) =>
    List<PresenciaAnimalViviendaModel>.from(
        json.decode(str).map((x) => PresenciaAnimalViviendaModel.fromJson(x)));

class PresenciaAnimalViviendaModel extends PresenciaAnimalViviendaEntity {
  PresenciaAnimalViviendaModel({
    required int presenciaAnimalViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          presenciaAnimalViviendaId: presenciaAnimalViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory PresenciaAnimalViviendaModel.fromJson(Map<String, dynamic> json) =>
      PresenciaAnimalViviendaModel(
        presenciaAnimalViviendaId: json["PresenciaAnimalVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
