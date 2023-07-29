class SeguimientoEnfermedadEntity {
  SeguimientoEnfermedadEntity({
    required this.seguimientoEnfermedadId,
    required this.descripcion,
  });

  int seguimientoEnfermedadId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "SeguimientoEnfermedad_id": seguimientoEnfermedadId,
        "Descripcion": descripcion,
      };
}
