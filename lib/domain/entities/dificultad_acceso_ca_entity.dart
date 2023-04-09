class DificultadAccesoCAEntity {
  DificultadAccesoCAEntity({
    required this.dificultaAccesoId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int dificultaAccesoId;
  String descripcion;
  int departamentoIde;

  factory DificultadAccesoCAEntity.fromJson(Map<String, dynamic> json) =>
      DificultadAccesoCAEntity(
        dificultaAccesoId: json["dificultaAcceso_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "dificultaAcceso_id": dificultaAccesoId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
