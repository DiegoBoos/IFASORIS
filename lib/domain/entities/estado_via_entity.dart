class EstadoViaEntity {
  EstadoViaEntity({
    required this.estadoViaId,
    required this.descripcion,
  });

  int estadoViaId;
  String descripcion;

  factory EstadoViaEntity.fromJson(Map<String, dynamic> json) =>
      EstadoViaEntity(
        estadoViaId: json["estadoVia_id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "estadoVia_id": estadoViaId,
        "descripcion": descripcion,
      };
}
