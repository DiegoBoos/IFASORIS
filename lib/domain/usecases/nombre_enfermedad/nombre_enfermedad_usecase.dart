import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nombre_enfermedad.dart';
import '../../repositories/nombre_enfermedad/nombre_enfermedad_repository.dart';

class NombreEnfermedadUsecase {
  final NombreEnfermedadRepository repository;

  NombreEnfermedadUsecase(this.repository);

  Future<Either<Failure, List<NombreEnfermedadEntity>>>
      getNombresEnfermedadesUsecase() {
    return repository.getNombresEnfermedadesRepository();
  }
}
