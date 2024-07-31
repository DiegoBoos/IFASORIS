import 'package:equatable/equatable.dart';

class LugarAtencionMedicoEntity extends Equatable {
  final int? lugarAtencionMedicoId;
  final String? descripcion;

  const LugarAtencionMedicoEntity({
    this.lugarAtencionMedicoId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        lugarAtencionMedicoId,
        descripcion,
      ];
}
