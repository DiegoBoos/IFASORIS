class CerealEntity {
  CerealEntity({
    required this.cerealId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int cerealId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "Cereal_id": cerealId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
