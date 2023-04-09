import 'package:ifasoris/domain/entities/usuario_entity.dart';

class UsuarioModel extends UsuarioEntity {
  UsuarioModel({
    required String id,
    required String userName,
    required int municipioId,
    required int departamentoId,
    required String password,
    required String token,
  }) : super(
          id: id,
          userName: userName,
          password: password,
          municipioId: municipioId,
          departamentoId: departamentoId,
          token: token,
        );

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        userName: json["userName"],
        municipioId: json["municipio_id"],
        departamentoId: json["departamento_id"],
        password: json["password"],
        token: json["token"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "municipio_id": municipioId,
        "departamento_id": departamentoId,
        "password": password,
        "token": token,
      };

  @override
  bool operator ==(Object other) => other is UsuarioModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
