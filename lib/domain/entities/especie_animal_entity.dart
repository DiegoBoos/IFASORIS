class EspecieAnimalEntity {
  EspecieAnimalEntity({
    required this.especieAnimalCriaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int especieAnimalCriaId;
  String descripcion;
  int departamentoIde;

  factory EspecieAnimalEntity.fromJson(Map<String, dynamic> json) =>
      EspecieAnimalEntity(
        especieAnimalCriaId: json["especieAnimalCria_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "especieAnimalCria_id": especieAnimalCriaId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
