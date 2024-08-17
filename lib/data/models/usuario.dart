import 'package:ifasoris/domain/entities/usuario.dart';

class UsuarioModel extends UsuarioEntity {
  const UsuarioModel({
    String? id,
    String? email,
    String? userName,
    String? password,
    String? deviceId,
    int? municipioId,
    int? departamentoId,
  }) : super(
          id: id,
          email: email,
          userName: userName,
          password: password,
          deviceId: deviceId,
          municipioId: municipioId,
          departamentoId: departamentoId,
        );

  factory UsuarioModel.fromEntity(UsuarioEntity entity) => UsuarioModel(
        id: entity.id,
        email: entity.email,
        userName: entity.userName,
        password: entity.password,
        deviceId: entity.deviceId,
        municipioId: entity.municipioId,
        departamentoId: entity.departamentoId,
      );

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["Id"],
        email: json["Email"],
        userName: json["UserName"],
        deviceId: json["Device_Id"],
        municipioId: json["Municipio_id"],
        departamentoId: json["Departamento_id"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Email": email,
        "UserName": userName,
        "Password": password,
        "Device_Id": deviceId,
        "Municipio_id": municipioId,
        "Departamento_id": departamentoId,
      };
}
