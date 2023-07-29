class ServicioSolicitadoEntity {
  ServicioSolicitadoEntity({
    required this.servicioSolicitadoId,
    required this.descripcion,
  });

  int servicioSolicitadoId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "ServicioSolicitado_id": servicioSolicitadoId,
        "Descripcion": descripcion,
      };
}
