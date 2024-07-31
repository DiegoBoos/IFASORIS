import 'package:equatable/equatable.dart';

class IluminacionViviendaEntity extends Equatable {
  final int? iluminacionViviendaId;
  final String? descripcion;

  const IluminacionViviendaEntity({
    this.iluminacionViviendaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        iluminacionViviendaId,
        descripcion,
      ];
}
