import 'package:equatable/equatable.dart';

class TratamientoAguaViviendaEntity extends Equatable {
  final int? tratamientoAguaViviendaId;
  final String? descripcion;
  final int? departamentoIde;

  const TratamientoAguaViviendaEntity({
    this.tratamientoAguaViviendaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        tratamientoAguaViviendaId,
        descripcion,
        departamentoIde,
      ];
}
