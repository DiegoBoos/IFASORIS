class CerealEntity {
  CerealEntity({
    required this.cerealId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int cerealId;
  String descripcion;
  int departamentoIde;

  factory CerealEntity.fromJson(Map<String, dynamic> json) => CerealEntity(
        cerealId: json["cereal_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "cereal_id": cerealId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
