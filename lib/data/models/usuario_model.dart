import 'package:ifasoris/domain/entities/usuario_entity.dart';

class UsuarioModel extends UsuarioEntity {
  UsuarioModel({
    required String id,
    required String userName,
    required int municipioId,
    required int departamentoId,
    required String password,
  }) : super(
          id: id,
          userName: userName,
          password: password,
          municipioId: municipioId,
          departamentoId: departamentoId,
        );

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["Id"],
        userName: json["UserName"],
        municipioId: json["Municipio_id"],
        departamentoId: json["Departamento_id"],
        password: json["Password"],
      );
}
