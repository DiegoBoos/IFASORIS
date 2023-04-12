class EspecialidadMedTradicionalEntity {
  EspecialidadMedTradicionalEntity({
    required this.especialidadMedTradId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int especialidadMedTradId;
  String descripcion;
  int departamentoIde;

  factory EspecialidadMedTradicionalEntity.fromJson(
          Map<String, dynamic> json) =>
      EspecialidadMedTradicionalEntity(
        especialidadMedTradId: json["especialidadMedTrad_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "especialidadMedTrad_id": especialidadMedTradId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
