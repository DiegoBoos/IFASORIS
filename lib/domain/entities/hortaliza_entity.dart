class HortalizaEntity {
  HortalizaEntity({
    required this.hortalizaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int hortalizaId;
  String descripcion;
  int departamentoIde;

  factory HortalizaEntity.fromJson(Map<String, dynamic> json) =>
      HortalizaEntity(
        hortalizaId: json["hortaliza_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "hortaliza_id": hortalizaId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
