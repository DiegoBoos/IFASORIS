class TechoViviendaEntity {
  int techoViviendaId;
  String descripcion;
  int departamentoIde;

  TechoViviendaEntity({
    required this.techoViviendaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  Map<String, dynamic> toJson() => {
        "TechoVivienda_id": techoViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
