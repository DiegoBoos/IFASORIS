class EstadoViaEntity {
  EstadoViaEntity({
    required this.estadoViaId,
    required this.descripcion,
  });

  int estadoViaId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "EstadoVia_id": estadoViaId,
        "Descripcion": descripcion,
      };
}
