class MedioComunicacionEntity {
  MedioComunicacionEntity({
    required this.medioComunicacionId,
    required this.descripcion,
  });

  int medioComunicacionId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "MedioComunicacion_id": medioComunicacionId,
        "Descripcion": descripcion,
      };
}
