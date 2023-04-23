class FichaEntity {
  FichaEntity({
    this.fechaCreacion,
    required this.numFicha,
    required this.encuestadorId,
    required this.userName,
    this.ultimaActualizacion,
  });

  DateTime? fechaCreacion;
  String numFicha;
  int encuestadorId;
  String userName;
  DateTime? ultimaActualizacion;

  FichaEntity copyWith({
    DateTime? fechaCreacion,
    String? numFicha,
    int? encuestadorId,
    String? userName,
    DateTime? ultimaActualizacion,
  }) =>
      FichaEntity(
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        numFicha: numFicha ?? this.numFicha,
        encuestadorId: encuestadorId ?? this.encuestadorId,
        userName: userName ?? this.userName,
        ultimaActualizacion: ultimaActualizacion ?? this.ultimaActualizacion,
      );

  Map<String, dynamic> toJson() => {
        "FechaCreacion": fechaCreacion?.toIso8601String(),
        "NumFicha": numFicha,
        "Encuestador_id": encuestadorId,
        "UserName": userName,
        "UltimaActualizacion": ultimaActualizacion?.toIso8601String(),
      };
}
