import '../../domain/entities/sync_log.dart';

class SyncLogModel extends SyncLogEntity {
  const SyncLogModel({String? tabla, int? cantidadRegistros});

  static SyncLogModel fromEntity(SyncLogEntity entity) {
    return SyncLogModel(
      tabla: entity.tabla,
      cantidadRegistros: entity.cantidadRegistros,
    );
  }

  factory SyncLogModel.fromJson(Map<String, dynamic> json) => SyncLogModel(
        tabla: json["Tabla"],
        cantidadRegistros: json["CantidadRegistros"],
      );

  Map<String, dynamic> toJson() =>
      {"Tabla": tabla, "CantidadRegistros": cantidadRegistros};
}
