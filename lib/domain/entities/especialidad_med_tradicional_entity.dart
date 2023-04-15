class EspecialidadMedTradicionalEntity {
  EspecialidadMedTradicionalEntity({
    required this.especialidadMedTradId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int especialidadMedTradId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "EspecialidadMedTrad_id": especialidadMedTradId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
