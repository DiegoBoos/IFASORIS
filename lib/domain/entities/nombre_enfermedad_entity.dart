class NombreEnfermedadEntity {
  NombreEnfermedadEntity({
    required this.nombreEnfermedadId,
    required this.descripcion,
  });

  int nombreEnfermedadId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "NombreEnfermedad_id": nombreEnfermedadId,
        "Descripcion": descripcion,
      };
}
