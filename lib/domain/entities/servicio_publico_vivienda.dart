import 'package:equatable/equatable.dart';

class ServicioPublicoViviendaEntity extends Equatable {
  final int? servicioPublicoViviendaId;
  final String? descripcion;
  final int? departamentoIde;

  const ServicioPublicoViviendaEntity({
    this.servicioPublicoViviendaId,
    this.descripcion,
    this.departamentoIde,
  });

  @override
  List<Object?> get props => [
        servicioPublicoViviendaId,
        descripcion,
        departamentoIde,
      ];
}
