class TipoSanitarioViviendaEntity {
  TipoSanitarioViviendaEntity({
    required this.tipoSanitarioViviendaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int tipoSanitarioViviendaId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "TipoSanitarioVivienda_id": tipoSanitarioViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
