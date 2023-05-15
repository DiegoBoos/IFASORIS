class PresenciaAnimalViviendaEntity {
  PresenciaAnimalViviendaEntity({
    required this.presenciaAnimalViviendaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int presenciaAnimalViviendaId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "PresenciaAnimalVivienda_id": presenciaAnimalViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
