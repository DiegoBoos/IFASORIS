class RegimenEntity {
  int regimenId;
  String descripcion;

  RegimenEntity({
    required this.regimenId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "Regimen_id": regimenId,
        "Descripcion": descripcion,
      };
}
