class FrutoEntity {
  FrutoEntity({
    required this.frutoId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int frutoId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "Fruto_id": frutoId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
