class FactorRiesgoViviendaEntity {
  FactorRiesgoViviendaEntity({
    required this.factorRiesgoViviendaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int factorRiesgoViviendaId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "FactorRiesgoVivienda_id": factorRiesgoViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
