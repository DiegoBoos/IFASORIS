class ServicioPublicoViviendaEntity {
  int servicioPublicoViviendaId;
  String descripcion;
  int departamentoIde;

  ServicioPublicoViviendaEntity({
    required this.servicioPublicoViviendaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  Map<String, dynamic> toJson() => {
        "ServicioPublicoVivienda_id": servicioPublicoViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
