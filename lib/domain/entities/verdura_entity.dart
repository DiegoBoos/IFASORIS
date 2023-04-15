class VerduraEntity {
  VerduraEntity({
    required this.verduraId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int verduraId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "Verdura_id": verduraId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
