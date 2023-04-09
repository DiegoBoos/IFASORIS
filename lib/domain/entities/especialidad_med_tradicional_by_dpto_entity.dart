class EspecialidadMedTradicionalByDptoEntity {
  EspecialidadMedTradicionalByDptoEntity({
    required this.especialidadMedTradId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int especialidadMedTradId;
  String descripcion;
  int departamentoIde;

  factory EspecialidadMedTradicionalByDptoEntity.fromJson(
          Map<String, dynamic> json) =>
      EspecialidadMedTradicionalByDptoEntity(
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
