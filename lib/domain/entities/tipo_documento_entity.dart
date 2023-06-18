class TipoDocumentoEntity {
  int tipoDocumentoId;
  String descripcion;

  TipoDocumentoEntity({
    required this.tipoDocumentoId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "TipoDocumento_id": tipoDocumentoId,
        "Descripcion": descripcion,
      };
}
