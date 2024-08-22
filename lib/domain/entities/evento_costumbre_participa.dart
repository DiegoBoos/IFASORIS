import 'package:equatable/equatable.dart';

class EventoCostumbreParticipaEntity extends Equatable {
  final int? eventoCostumbreParticipaId;
  final String? descripcion;
  final int? departamentoId;

  const EventoCostumbreParticipaEntity({
    this.eventoCostumbreParticipaId,
    this.descripcion,
    this.departamentoId,
  });

  @override
  List<Object?> get props => [
        eventoCostumbreParticipaId,
        descripcion,
        departamentoId,
      ];
}
