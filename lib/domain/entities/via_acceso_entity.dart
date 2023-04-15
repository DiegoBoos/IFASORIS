class ViaAccesoEntity {
  ViaAccesoEntity({
    required this.viaAccesoId,
    required this.descripcion,
  });

  int viaAccesoId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "ViaAcceso_id": viaAccesoId,
        "Descripcion": descripcion,
      };
}
