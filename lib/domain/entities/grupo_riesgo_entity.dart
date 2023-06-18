class GrupoRiesgoEntity {
  GrupoRiesgoEntity({
    required this.grupoRiesgoId,
    required this.descripcion,
  });

  int grupoRiesgoId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "GrupoRiesgo_id": grupoRiesgoId,
        "Descripcion": descripcion,
      };
}
