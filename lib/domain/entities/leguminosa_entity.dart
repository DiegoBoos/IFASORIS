class LeguminosaEntity {
  LeguminosaEntity({
    required this.leguminosaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int leguminosaId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "Leguminosa_id": leguminosaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
