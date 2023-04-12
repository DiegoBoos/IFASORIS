class VerduraEntity {
  VerduraEntity({
    required this.verduraId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int verduraId;
  String descripcion;
  int departamentoIde;

  factory VerduraEntity.fromJson(Map<String, dynamic> json) => VerduraEntity(
        verduraId: json["verdura_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "verdura_id": verduraId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
