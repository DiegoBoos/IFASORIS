class LeguminosaEntity {
  LeguminosaEntity({
    required this.leguminosaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int leguminosaId;
  String descripcion;
  int departamentoIde;

  factory LeguminosaEntity.fromJson(Map<String, dynamic> json) =>
      LeguminosaEntity(
        leguminosaId: json["leguminosa_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "leguminosa_id": leguminosaId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
