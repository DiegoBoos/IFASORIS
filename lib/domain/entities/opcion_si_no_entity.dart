class OpcionSiNoEntity {
  OpcionSiNoEntity({
    required this.opcionId,
    required this.descripcion,
  });

  int opcionId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "Opcion_id": opcionId,
        "Descripcion": descripcion,
      };
}
