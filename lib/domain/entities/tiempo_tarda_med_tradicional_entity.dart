class TiempoTardaMedTradicionalEntity {
  TiempoTardaMedTradicionalEntity({
    required this.tiempoTardaMedTradId,
    required this.descripcion,
  });

  int tiempoTardaMedTradId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "TiempoTardaMedTrad_id": tiempoTardaMedTradId,
        "Descripcion": descripcion,
      };
}
