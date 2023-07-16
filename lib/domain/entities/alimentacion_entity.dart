class AlimentacionEntity {
  int alimentacionId;
  String descripcion;

  AlimentacionEntity({
    required this.alimentacionId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "Alimentacion_id": alimentacionId,
        "Descripcion": descripcion,
      };
}
