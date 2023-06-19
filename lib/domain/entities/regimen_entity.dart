class RegimenEntity {
  int tipoRegimenId;
  String tipo;
  String descripcion;

  RegimenEntity({
    required this.tipoRegimenId,
    required this.tipo,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "TipoRegimen_id": tipoRegimenId,
        "Tipo": tipo,
        "Descripcion": descripcion,
      };
}
