class OpcionSiNoEntity {
  OpcionSiNoEntity({
    required this.opcionId,
    required this.descripcion,
  });

  int opcionId;
  String descripcion;

  factory OpcionSiNoEntity.fromJson(Map<String, dynamic> json) =>
      OpcionSiNoEntity(
        opcionId: json["opcion_id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "opcion_id": opcionId,
        "descripcion": descripcion,
      };
}
