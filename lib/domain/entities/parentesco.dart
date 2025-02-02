import 'package:equatable/equatable.dart';

class ParentescoEntity extends Equatable {
  final int? parentescoId;
  final String? descripcion;

  const ParentescoEntity({
    this.parentescoId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        parentescoId,
        descripcion,
      ];
}
