class MedioComunicacionEntity {
  MedioComunicacionEntity({
    required this.medioComunicacionId,
    required this.descripcion,
  });

  int medioComunicacionId;
  String descripcion;

  factory MedioComunicacionEntity.fromJson(Map<String, dynamic> json) =>
      MedioComunicacionEntity(
        medioComunicacionId: json["medioComunicacion_id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "medioComunicacion_id": medioComunicacionId,
        "descripcion": descripcion,
      };
}
