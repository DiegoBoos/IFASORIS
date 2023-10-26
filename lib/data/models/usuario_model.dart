import 'package:ifasoris/domain/entities/usuario_entity.dart';

class UsuarioModel extends UsuarioEntity {
  UsuarioModel({
    required String id,
    required String userName,
    required String password,
    required String deviceId,
    required int municipioId,
    required int departamentoId,
  }) : super(
          id: id,
          userName: userName,
          password: password,
          deviceId: deviceId,
          municipioId: municipioId,
          departamentoId: departamentoId,
        );

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["Id"],
        userName: json["UserName"],
        password: json["Password"],
        deviceId: json["Device_Id"],
        municipioId: json["Municipio_id"],
        departamentoId: json["Departamento_id"],
      );
}
