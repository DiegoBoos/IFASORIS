import 'familia_entity.dart';

class FichaEntity {
  int? fichaId;
  DateTime? fechaCreacion;
  String? numFicha;
  String? userNameCreacion;
  String? userNameActualizacion;
  DateTime? ultimaActualizacion;
  FamiliaEntity? familia;
  int? fichaIdRemote;

  FichaEntity({
    this.fichaId,
    this.fechaCreacion,
    this.numFicha,
    this.userNameCreacion,
    this.userNameActualizacion,
    this.ultimaActualizacion,
    this.familia,
    this.fichaIdRemote,
  });

  Map<String, dynamic> toJsonLocalCompleta() => {
        "Ficha_id_remote": fichaId,
        "FechaCreacion": fechaCreacion?.toIso8601String(),
        "NumFicha": numFicha,
        "UserName_Creacion": userNameCreacion,
        "UserName_Actualizacion": userNameActualizacion,
        "UltimaActualizacion": ultimaActualizacion?.toIso8601String(),
        "familia": familia,
      };

  Map<String, dynamic> toJsonLocal() => {
        "Ficha_id": fichaId,
        "FechaCreacion": fechaCreacion?.toIso8601String(),
        "NumFicha": numFicha,
        "UserName_Creacion": userNameCreacion,
        "UserName_Actualizacion": userNameActualizacion,
        "UltimaActualizacion": ultimaActualizacion?.toIso8601String(),
        "Ficha_id_remote": fichaIdRemote,
      };

  Map<String, dynamic> toJsonRemote() => {
        "Ficha_id": fichaId,
        "FechaCreacion": fechaCreacion?.toIso8601String(),
        "NumFicha": numFicha,
        "UserName_Creacion": userNameCreacion,
        "UserName_Actualizacion": userNameActualizacion,
        "UltimaActualizacion": ultimaActualizacion?.toIso8601String(),
      };
}
