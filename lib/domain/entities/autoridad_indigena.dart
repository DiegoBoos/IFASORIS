import 'package:equatable/equatable.dart';

class AutoridadIndigenaEntity extends Equatable {
  final int? autoridadIndigenaId;
  final String? descripcion;
  const AutoridadIndigenaEntity({
    this.autoridadIndigenaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        autoridadIndigenaId,
        descripcion,
      ];
}
