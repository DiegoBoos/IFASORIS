class OcupacionEntity {
  int ocupacionId;
  String descripcion;

  OcupacionEntity({
    required this.ocupacionId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "Ocupacion_id": ocupacionId,
        "Descripcion": descripcion,
      };
}
