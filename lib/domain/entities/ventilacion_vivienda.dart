import 'package:equatable/equatable.dart';

class VentilacionViviendaEntity extends Equatable {
  final int? ventilacionViviendaId;
  final String? descripcion;

  const VentilacionViviendaEntity({
    this.ventilacionViviendaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        ventilacionViviendaId,
        descripcion,
      ];
}
