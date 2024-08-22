import 'package:equatable/equatable.dart';

class NroCuartoViviendaEntity extends Equatable {
  final int? nroCuartoViviendaId;
  final String? descripcion;

  const NroCuartoViviendaEntity({
    this.nroCuartoViviendaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        nroCuartoViviendaId,
        descripcion,
      ];
}
