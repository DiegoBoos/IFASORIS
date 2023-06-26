import 'dart:convert';

import '../../domain/entities/tipo_documento_entity.dart';

List<TipoDocumentoModel> tiposDocumentoFromJson(String str) =>
    List<TipoDocumentoModel>.from(
        json.decode(str).map((x) => TipoDocumentoModel.fromJson(x)));

class TipoDocumentoModel extends TipoDocumentoEntity {
  TipoDocumentoModel({
    required int tipoDocumentoId,
    required String tipo,
    required String descripcion,
  }) : super(
          tipoDocumentoId: tipoDocumentoId,
          tipo: tipo,
          descripcion: descripcion,
        );

  factory TipoDocumentoModel.fromJson(Map<String, dynamic> json) =>
      TipoDocumentoModel(
        tipoDocumentoId: json["TipoDocumento_id"],
        tipo: json["Tipo"],
        descripcion: json["Descripcion"],
      );
}
