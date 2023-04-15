class AutoridadIndigenaEntity {
  AutoridadIndigenaEntity({
    required this.autoridadIndigenaId,
    required this.descripcion,
  });

  int autoridadIndigenaId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "AutoridadIndigena_id": autoridadIndigenaId,
        "Descripcion": descripcion,
      };
}
