class DificultadAccesoMedTradicionalEntity {
  DificultadAccesoMedTradicionalEntity({
    required this.dificultadAccesoMedTradId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int dificultadAccesoMedTradId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "DificultadAccesoMedTrad_id": dificultadAccesoMedTradId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
