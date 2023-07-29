class EsquemaVacunacionEntity {
  EsquemaVacunacionEntity({
    required this.esquemaVacunacionId,
    required this.descripcion,
  });

  int esquemaVacunacionId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "EsquemaVacunacion_id": esquemaVacunacionId,
        "Descripcion": descripcion,
      };
}
