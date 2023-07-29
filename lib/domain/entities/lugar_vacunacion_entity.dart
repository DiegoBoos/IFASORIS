class LugarVacunacionEntity {
  LugarVacunacionEntity({
    required this.lugarVacunacionId,
    required this.descripcion,
  });

  int lugarVacunacionId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "LugarVacunacion_id": lugarVacunacionId,
        "Descripcion": descripcion,
      };
}
