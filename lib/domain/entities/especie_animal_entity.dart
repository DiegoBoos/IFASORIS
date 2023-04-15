class EspecieAnimalEntity {
  EspecieAnimalEntity({
    required this.especieAnimalCriaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int especieAnimalCriaId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "EspecieAnimalCria_id": especieAnimalCriaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
