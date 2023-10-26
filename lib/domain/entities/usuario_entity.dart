class UsuarioEntity {
  UsuarioEntity({
    this.id,
    required this.userName,
    required this.password,
    required this.deviceId,
    this.municipioId,
    this.departamentoId,
  });

  final String? id;
  final String userName;
  final String? password;
  final String? deviceId;
  final int? municipioId;
  final int? departamentoId;

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserName": userName,
        "Password": password,
        "Device_Id": deviceId,
        "Municipio_id": municipioId,
        "Departamento_id": departamentoId,
      };
}
