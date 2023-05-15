import 'dart:convert';

import '../../domain/entities/tipo_combustible_vivienda_entity.dart';

List<TipoCombustibleViviendaModel> tiposCombustibleViviendaFromJson(
        String str) =>
    List<TipoCombustibleViviendaModel>.from(
        json.decode(str).map((x) => TipoCombustibleViviendaModel.fromJson(x)));

class TipoCombustibleViviendaModel extends TipoCombustibleViviendaEntity {
  TipoCombustibleViviendaModel({
    required int tipoCombustibleViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          tipoCombustibleViviendaId: tipoCombustibleViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory TipoCombustibleViviendaModel.fromJson(Map<String, dynamic> json) =>
      TipoCombustibleViviendaModel(
        tipoCombustibleViviendaId: json["TipoCombustibleVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
