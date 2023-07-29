class PlantaMedicinalEntity {
  int plantaMedicinalId;
  String descripcion;

  PlantaMedicinalEntity({
    required this.plantaMedicinalId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "PlantaMedicinal_id": plantaMedicinalId,
        "Descripcion": descripcion,
      };
}
