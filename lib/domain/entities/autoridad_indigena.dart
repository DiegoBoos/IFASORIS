import 'package:equatable/equatable.dart';

class AutoridadIndigenaEntity extends Equatable {
  final int? autoridadIndigenaId;
  final String? descripcion;
  final int? departamentoId;
  const AutoridadIndigenaEntity({
    this.autoridadIndigenaId,
    this.descripcion,
    this.departamentoId,
  });

  @override
  List<Object?> get props => [
        autoridadIndigenaId,
        descripcion,
        departamentoId,
      ];
}
