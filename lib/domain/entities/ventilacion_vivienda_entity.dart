class VentilacionViviendaEntity {
  VentilacionViviendaEntity({
    required this.ventilacionViviendaId,
    required this.descripcion,
  });

  int ventilacionViviendaId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "VentilacionVivienda_id": ventilacionViviendaId,
        "Descripcion": descripcion,
      };
}
