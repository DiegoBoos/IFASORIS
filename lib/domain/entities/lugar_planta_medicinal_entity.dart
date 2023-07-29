class LugarPlantaMedicinalEntity {
  int lugarPlantaMedicinalId;
  String descripcion;

  LugarPlantaMedicinalEntity({
    required this.lugarPlantaMedicinalId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "LugarPlantaMedicinal_id": lugarPlantaMedicinalId,
        "Descripcion": descripcion,
      };
}
