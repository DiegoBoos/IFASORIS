class TratamientoAguaViviendaEntity {
  TratamientoAguaViviendaEntity({
    required this.tratamientoAguaViviendaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int tratamientoAguaViviendaId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "TratamientoAguaVivienda_id": tratamientoAguaViviendaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
