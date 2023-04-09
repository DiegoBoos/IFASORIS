class UsuarioEntity {
  UsuarioEntity({
    this.id,
    required this.userName,
    this.password,
    this.municipioId,
    this.departamentoId,
    this.token,
  });

  final String? id;
  final String userName;
  final int? municipioId;
  final int? departamentoId;
  final String? password;
  final String? token;

  factory UsuarioEntity.fromJson(Map<String, dynamic> json) => UsuarioEntity(
        id: json["id"],
        userName: json["userName"],
        municipioId: json["municipio_id"],
        departamentoId: json["departamento_id"],
        password: json["password"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "password": password,
        "municipio_id": municipioId,
        "departamento_id": departamentoId,
        "token": token,
      };
}
