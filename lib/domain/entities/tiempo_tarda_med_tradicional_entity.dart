class TiempoTardaMedTradicionalEntity {
  TiempoTardaMedTradicionalEntity({
    required this.tiempoTardaMedTradId,
    required this.descripcion,
  });

  int tiempoTardaMedTradId;
  String descripcion;

  factory TiempoTardaMedTradicionalEntity.fromJson(Map<String, dynamic> json) =>
      TiempoTardaMedTradicionalEntity(
        tiempoTardaMedTradId: json["tiempoTardaMedTrad_id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "tiempoTardaMedTrad_id": tiempoTardaMedTradId,
        "descripcion": descripcion,
      };
}
