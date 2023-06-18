import 'dart:convert';

import '../../domain/entities/tipo_documento_entity.dart';

List<TipoDocumentoModel> tiposDocumentoFromJson(String str) =>
    List<TipoDocumentoModel>.from(
        json.decode(str).map((x) => TipoDocumentoModel.fromJson(x)));

class TipoDocumentoModel extends TipoDocumentoEntity {
  TipoDocumentoModel({
    required int tipoDocumentoId,
    required String descripcion,
  }) : super(
          tipoDocumentoId: tipoDocumentoId,
          descripcion: descripcion,
        );

  factory TipoDocumentoModel.fromJson(Map<String, dynamic> json) =>
      TipoDocumentoModel(
        tipoDocumentoId: json["TipoDocumento_id"],
        descripcion: json["Descripcion"],
      );
}
