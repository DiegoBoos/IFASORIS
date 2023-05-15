class TenenciaViviendaEntity {
  int tenenciaViviendaId;
  String descripcion;
  int departamentoIde;

  TenenciaViviendaEntity({
    required this.tenenciaViviendaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  Map<String, dynamic> toJson() => {
        "TenenciaVivienda_id": tenenciaViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
