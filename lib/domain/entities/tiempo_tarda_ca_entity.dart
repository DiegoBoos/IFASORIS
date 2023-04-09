class TiempoTardaCAEntity {
  TiempoTardaCAEntity({
    required this.tiempoTardaId,
    required this.descripcion,
  });

  int tiempoTardaId;
  String descripcion;

  factory TiempoTardaCAEntity.fromJson(Map<String, dynamic> json) =>
      TiempoTardaCAEntity(
        tiempoTardaId: json["tiempoTarda_id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "tiempoTarda_id": tiempoTardaId,
        "descripcion": descripcion,
      };
}
