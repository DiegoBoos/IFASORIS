import 'package:equatable/equatable.dart';

class GeneroEntity extends Equatable {
  final int? generoId;
  final String? tipo;
  final String? descripcion;

  const GeneroEntity({
    this.generoId,
    this.tipo,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        generoId,
        tipo,
        descripcion,
      ];
}
