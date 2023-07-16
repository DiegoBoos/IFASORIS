class ActividadFisicaEntity {
  int actividadFisicaId;
  String descripcion;

  ActividadFisicaEntity({
    required this.actividadFisicaId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "ActividadFisica_id": actividadFisicaId,
        "Descripcion": descripcion,
      };
}
