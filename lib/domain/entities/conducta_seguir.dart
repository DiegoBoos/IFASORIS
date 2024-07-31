import 'package:equatable/equatable.dart';

class ConductaSeguirEntity extends Equatable {
  final int? conductaSeguirId;
  final String? descripcion;

  const ConductaSeguirEntity({
    this.conductaSeguirId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        conductaSeguirId,
        descripcion,
      ];
}
