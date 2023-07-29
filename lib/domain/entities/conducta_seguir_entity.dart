class ConductaSeguirEntity {
  ConductaSeguirEntity({
    required this.conductaSeguirId,
    required this.descripcion,
  });

  int conductaSeguirId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "ConductaSeguir_id": conductaSeguirId,
        "Descripcion": descripcion,
      };
}
