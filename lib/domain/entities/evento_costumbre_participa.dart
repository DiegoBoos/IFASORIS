import 'package:equatable/equatable.dart';

class EventoCostumbreParticipaEntity extends Equatable {
  final int? eventoCostumbreParticipaId;
  final String? descripcion;

  const EventoCostumbreParticipaEntity({
    this.eventoCostumbreParticipaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        eventoCostumbreParticipaId,
        descripcion,
      ];
}
