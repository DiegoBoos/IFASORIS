class NroCuartoViviendaEntity {
  int nroCuartoViviendaId;
  String descripcion;

  NroCuartoViviendaEntity({
    required this.nroCuartoViviendaId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "NroCuartosVivienda_id": nroCuartoViviendaId,
        "Descripcion": descripcion,
      };
}
