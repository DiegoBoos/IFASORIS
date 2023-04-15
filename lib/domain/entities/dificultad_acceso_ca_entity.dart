class DificultadAccesoCAEntity {
  DificultadAccesoCAEntity({
    required this.dificultaAccesoId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int dificultaAccesoId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "DificultaAcceso_id": dificultaAccesoId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
