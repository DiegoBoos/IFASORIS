import 'package:equatable/equatable.dart';

class UsuarioEntity extends Equatable {
  final String? id;
  final String? userName;
  final String? password;
  final String? deviceId;
  final int? municipioId;
  final int? departamentoId;

  const UsuarioEntity({
    this.id,
    this.userName,
    this.password,
    this.deviceId,
    this.municipioId,
    this.departamentoId,
  });

  @override
  List<Object?> get props => [
        id,
        userName,
        password,
        deviceId,
        municipioId,
        departamentoId,
      ];
}
