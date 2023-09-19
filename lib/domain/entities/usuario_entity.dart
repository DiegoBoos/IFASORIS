class UsuarioEntity {
  UsuarioEntity({
    this.id,
    required this.userName,
    this.password,
    this.municipioId,
    this.departamentoId,
  });

  final String? id;
  final String userName;
  final int? municipioId;
  final int? departamentoId;
  final String? password;

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserName": userName,
        "Municipio_id": municipioId,
        "Departamento_id": departamentoId,
        "Password": password,
      };
}
