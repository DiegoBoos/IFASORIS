class TiempoTardaCAEntity {
  TiempoTardaCAEntity({
    required this.tiempoTardaId,
    required this.descripcion,
  });

  int tiempoTardaId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "TiempoTarda_id": tiempoTardaId,
        "Descripcion": descripcion,
      };
}
