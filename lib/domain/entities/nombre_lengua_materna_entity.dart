class NombreLenguaMaternaEntity {
  NombreLenguaMaternaEntity({
    required this.lenguaMaternaId,
    required this.descripcion,
  });

  int lenguaMaternaId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "LenguaMaterna_id": lenguaMaternaId,
        "Descripcion": descripcion,
      };
}
