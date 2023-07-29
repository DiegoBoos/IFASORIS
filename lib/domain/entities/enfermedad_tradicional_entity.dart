class EnfermedadTradicionalEntity {
  int enfermedadTradicionalId;
  String descripcion;

  EnfermedadTradicionalEntity({
    required this.enfermedadTradicionalId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "EnfermedadTradicional_id": enfermedadTradicionalId,
        "Descripcion": descripcion,
      };
}
