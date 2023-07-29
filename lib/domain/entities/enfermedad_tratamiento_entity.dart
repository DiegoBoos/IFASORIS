class EnfermedadTratamientoEntity {
  int enfermedadTratamientoId;
  String descripcion;

  EnfermedadTratamientoEntity({
    required this.enfermedadTratamientoId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "EnfermedadTratamiento_id": enfermedadTratamientoId,
        "Descripcion": descripcion,
      };
}
