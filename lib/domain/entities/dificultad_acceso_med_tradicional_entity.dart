class DificultadAccesoMedTradicionalEntity {
  DificultadAccesoMedTradicionalEntity({
    required this.dificultaAccesoMedTradId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int dificultaAccesoMedTradId;
  String descripcion;
  int departamentoIde;

  factory DificultadAccesoMedTradicionalEntity.fromJson(
          Map<String, dynamic> json) =>
      DificultadAccesoMedTradicionalEntity(
        dificultaAccesoMedTradId: json["dificultaAccesoMedTrad_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "dificultaAccesoMedTrad_id": dificultaAccesoMedTradId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
