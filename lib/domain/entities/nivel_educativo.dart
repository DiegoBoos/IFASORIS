import 'package:equatable/equatable.dart';

class NivelEducativoEntity extends Equatable {
  final int? nivelEducativoId;
  final String? descripcion;

  const NivelEducativoEntity({
    this.nivelEducativoId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        nivelEducativoId,
        descripcion,
      ];
}
