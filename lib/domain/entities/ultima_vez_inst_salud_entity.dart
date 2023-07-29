class UltimaVezInstSaludEntity {
  UltimaVezInstSaludEntity({
    required this.ultimaVezInstSaludId,
    required this.descripcion,
  });

  int ultimaVezInstSaludId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "UltimaVezInstSalud_id": ultimaVezInstSaludId,
        "Descripcion": descripcion,
      };
}
