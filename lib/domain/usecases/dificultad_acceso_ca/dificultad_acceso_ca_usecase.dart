import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dificultad_acceso_ca_entity.dart';
import '../../repositories/dificultad_acceso_ca/dificultad_acceso_ca_repository.dart';

class DificultadAccesoCAUsecase {
  final DificultadAccesoCARepository repository;

  DificultadAccesoCAUsecase(this.repository);

  Future<Either<Failure, List<DificultadAccesoCAEntity>>>
      getDificultadesAccesoCAUsecase() {
    return repository.getDificultadesAccesoCARepository();
  }
}
