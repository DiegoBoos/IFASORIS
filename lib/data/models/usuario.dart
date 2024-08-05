import 'package:ifasoris/domain/entities/usuario.dart';

class UsuarioModel extends UsuarioEntity {
  const UsuarioModel({
    String? id,
    String? userName,
    String? password,
    String? deviceId,
    int? municipioId,
    int? departamentoId,
  });

  factory UsuarioModel.fromEntity(UsuarioEntity entity) => UsuarioModel(
        id: entity.id,
        userName: entity.userName,
        password: entity.password,
        deviceId: entity.deviceId,
        municipioId: entity.municipioId,
        departamentoId: entity.departamentoId,
      );

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["Id"],
        userName: json["UserName"],
        password: json["Password"],
        deviceId: json["Device_Id"],
        municipioId: json["Municipio_id"],
        departamentoId: json["Departamento_id"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserName": userName,
        "Password": password,
        "Device_Id": deviceId,
        "Municipio_id": municipioId,
        "Departamento_id": departamentoId,
      };
}
