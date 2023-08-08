import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/piso_vivienda_entity.dart';
import '../../repositories/piso_vivienda/piso_vivienda_repository.dart';

class PisoViviendaUsecase {
  final PisoViviendaRepository repository;

  PisoViviendaUsecase(this.repository);

  Future<Either<Failure, List<PisoViviendaEntity>>> getPisosViviendaUsecase(
      int dtoId) {
    return repository.getPisosViviendaRepository(dtoId);
  }
}
