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

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Username": userName,
        "Password": password,
        "Municipio_Id": municipioId,
        "Departamento_Id": departamentoId,
        "Token": token,
      };
}
