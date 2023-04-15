class CostoDesplazamientoEntity {
  CostoDesplazamientoEntity({
    required this.costoDesplazamientoId,
    required this.descripcion,
  });

  int costoDesplazamientoId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "CostoDesplazamiento_id": costoDesplazamientoId,
        "Descripcion": descripcion,
      };
}
