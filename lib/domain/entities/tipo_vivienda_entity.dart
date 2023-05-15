class TipoViviendaEntity {
  int tipoViviendaId;
  String descripcion;
  int departamentoIde;

  TipoViviendaEntity({
    required this.tipoViviendaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  Map<String, dynamic> toJson() => {
        "TipoVivienda_id": tipoViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
