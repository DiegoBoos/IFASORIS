class HortalizaEntity {
  HortalizaEntity({
    required this.hortalizaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int hortalizaId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "Hortaliza_id": hortalizaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
