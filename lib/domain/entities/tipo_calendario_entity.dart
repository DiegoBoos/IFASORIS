class TipoCalendarioEntity {
  int tipoCalendarioId;
  String descripcion;

  TipoCalendarioEntity({
    required this.tipoCalendarioId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "TipoCalendario_id": tipoCalendarioId,
        "Descripcion": descripcion,
      };
}
