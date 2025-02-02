import 'package:equatable/equatable.dart';

class Equipo extends Equatable {
  final String? idEquipo;
  final String? modeloEquipo;

  const Equipo({
    this.idEquipo,
    this.modeloEquipo,
  });

  @override
  List<Object?> get props => [
        idEquipo,
        modeloEquipo,
      ];
}
