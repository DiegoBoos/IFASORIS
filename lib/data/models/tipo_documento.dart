import 'dart:convert';

import '../../domain/entities/tipo_documento.dart';

List<TipoDocumentoModel> tiposDocumentoFromJson(String str) =>
    List<TipoDocumentoModel>.from(
        json.decode(str).map((x) => TipoDocumentoModel.fromJson(x)));

class TipoDocumentoModel extends TipoDocumentoEntity {
  const TipoDocumentoModel({
    super.tipoDocumentoId,
    super.tipo,
    super.descripcion,
  });

  factory TipoDocumentoModel.fromEntity(TipoDocumentoEntity entity) {
    return TipoDocumentoModel(
      tipoDocumentoId: entity.tipoDocumentoId,
      tipo: entity.tipo,
      descripcion: entity.descripcion,
    );
  }

  factory TipoDocumentoModel.fromJson(Map<String, dynamic> json) =>
      TipoDocumentoModel(
        tipoDocumentoId: json["TipoDocumento_id"],
        tipo: json["Tipo"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "TipoDocumento_id": tipoDocumentoId,
        "Tipo": tipo,
        "Descripcion": descripcion,
      };
}
