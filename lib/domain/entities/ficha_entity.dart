class FichaEntity {
  FichaEntity({
    this.fichaId,
    this.fechaCreacion,
    required this.numFicha,
    required this.userName,
    this.ultimaActualizacion,
  });
  int? fichaId;
  DateTime? fechaCreacion;
  String numFicha;
  String userName;
  DateTime? ultimaActualizacion;

  FichaEntity copyWith({
    int? fichaId,
    DateTime? fechaCreacion,
    String? numFicha,
    String? userName,
    DateTime? ultimaActualizacion,
  }) =>
      FichaEntity(
        fichaId: fichaId ?? this.fichaId,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        numFicha: numFicha ?? this.numFicha,
        userName: userName ?? this.userName,
        ultimaActualizacion: ultimaActualizacion ?? this.ultimaActualizacion,
      );

  Map<String, dynamic> toJson() => {
        "FechaCreacion": fechaCreacion?.toIso8601String(),
        "NumFicha": numFicha,
        "UserName": userName,
        "UltimaActualizacion": ultimaActualizacion?.toIso8601String(),
      };
}
