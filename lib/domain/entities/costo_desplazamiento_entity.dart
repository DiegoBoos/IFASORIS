class CostoDesplazamientoEntity {
  CostoDesplazamientoEntity({
    required this.costoDesplazamientoId,
    required this.descripcion,
  });

  int costoDesplazamientoId;
  String descripcion;

  factory CostoDesplazamientoEntity.fromJson(Map<String, dynamic> json) =>
      CostoDesplazamientoEntity(
        costoDesplazamientoId: json["costoDesplazamiento_id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "costoDesplazamiento_id": costoDesplazamientoId,
        "descripcion": descripcion,
      };
}
