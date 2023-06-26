class TipoDocumentoEntity {
  int tipoDocumentoId;
  String tipo;
  String descripcion;

  TipoDocumentoEntity({
    required this.tipoDocumentoId,
    required this.tipo,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "TipoDocumento_id": tipoDocumentoId,
        "Tipo": tipo,
        "Descripcion": descripcion,
      };
}
