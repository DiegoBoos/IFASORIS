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
        "Regimen_id": tipoRegimenId,
        "Codigo": tipo,
        "Descripcion": descripcion,
      };
}
