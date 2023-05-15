import 'dart:convert';

import '../../domain/entities/tratamiento_agua_vivienda_entity.dart';

List<TratamientoAguaViviendaModel> tratamientosAguaViviendaFromJson(
        String str) =>
    List<TratamientoAguaViviendaModel>.from(
        json.decode(str).map((x) => TratamientoAguaViviendaModel.fromJson(x)));

class TratamientoAguaViviendaModel extends TratamientoAguaViviendaEntity {
  TratamientoAguaViviendaModel({
    required int tratamientoAguaViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          tratamientoAguaViviendaId: tratamientoAguaViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory TratamientoAguaViviendaModel.fromJson(Map<String, dynamic> json) =>
      TratamientoAguaViviendaModel(
        tratamientoAguaViviendaId: json["TratamientoAguaVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
