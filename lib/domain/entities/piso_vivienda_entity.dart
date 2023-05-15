class PisoViviendaEntity {
  int pisoViviendaId;
  String descripcion;
  int departamentoIde;

  PisoViviendaEntity({
    required this.pisoViviendaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  Map<String, dynamic> toJson() => {
        "PisoVivienda_id": pisoViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
