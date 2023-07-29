class EnfermedadAcudeEntity {
  int enfermedadAcudeId;
  String descripcion;

  EnfermedadAcudeEntity({
    required this.enfermedadAcudeId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "EnfermedadAcude_id": enfermedadAcudeId,
        "Descripcion": descripcion,
      };
}
