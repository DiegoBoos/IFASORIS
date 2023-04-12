class FrutoEntity {
  FrutoEntity({
    required this.frutoId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int frutoId;
  String descripcion;
  int departamentoIde;

  factory FrutoEntity.fromJson(Map<String, dynamic> json) => FrutoEntity(
        frutoId: json["fruto_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "fruto_id": frutoId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
