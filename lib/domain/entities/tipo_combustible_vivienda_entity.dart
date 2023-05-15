class TipoCombustibleViviendaEntity {
  TipoCombustibleViviendaEntity({
    required this.tipoCombustibleViviendaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int tipoCombustibleViviendaId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "TipoCombustibleVivienda_id": tipoCombustibleViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
