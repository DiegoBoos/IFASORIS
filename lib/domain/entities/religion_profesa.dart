import 'package:equatable/equatable.dart';

class ReligionProfesaEntity extends Equatable {
  final int? religionProfesaId;
  final String? descripcion;

  const ReligionProfesaEntity({
    this.religionProfesaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        religionProfesaId,
        descripcion,
      ];
}
