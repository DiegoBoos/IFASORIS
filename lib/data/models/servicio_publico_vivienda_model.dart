import 'dart:convert';

import '../../domain/entities/servicio_publico_vivienda_entity.dart';

List<ServicioPublicoViviendaModel> serviciosPublicosViviendaFromJson(
        String str) =>
    List<ServicioPublicoViviendaModel>.from(
        json.decode(str).map((x) => ServicioPublicoViviendaModel.fromJson(x)));

class ServicioPublicoViviendaModel extends ServicioPublicoViviendaEntity {
  ServicioPublicoViviendaModel({
    required int servicioPublicoViviendaId,
    required String descripcion,
    required int departamentoIde,
  }) : super(
          servicioPublicoViviendaId: servicioPublicoViviendaId,
          descripcion: descripcion,
          departamentoIde: departamentoIde,
        );

  factory ServicioPublicoViviendaModel.fromJson(Map<String, dynamic> json) =>
      ServicioPublicoViviendaModel(
        servicioPublicoViviendaId: json["ServicioPublicoVivienda_id"],
        descripcion: json["Descripcion"],
        departamentoIde: json["Departamento_Ide"],
      );
}
