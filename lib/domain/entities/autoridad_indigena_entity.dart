class AutoridadIndigenaEntity {
  AutoridadIndigenaEntity({
    required this.autoridadIndigenaId,
    required this.descripcion,
  });

  int autoridadIndigenaId;
  String descripcion;

  factory AutoridadIndigenaEntity.fromJson(Map<String, dynamic> json) =>
      AutoridadIndigenaEntity(
        autoridadIndigenaId: json["autoridadIndigena_id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "autoridadIndigena_id": autoridadIndigenaId,
        "descripcion": descripcion,
      };
}
