class ViaAccesoEntity {
  ViaAccesoEntity({
    required this.viaAccesoId,
    required this.descripcion,
  });

  int viaAccesoId;
  String descripcion;

  factory ViaAccesoEntity.fromJson(Map<String, dynamic> json) =>
      ViaAccesoEntity(
        viaAccesoId: json["viaAcceso_id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "viaAcceso_id": viaAccesoId,
        "descripcion": descripcion,
      };
}
