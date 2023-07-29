class MetodoPlanificacionEntity {
  MetodoPlanificacionEntity({
    required this.metodoPlanificacionId,
    required this.descripcion,
  });

  int metodoPlanificacionId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "MetodoPlanificacion_id": metodoPlanificacionId,
        "Descripcion": descripcion,
      };
}
