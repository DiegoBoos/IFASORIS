import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/piso_vivienda_entity.dart';
import '../../repositories/piso_vivienda_by_dpto/piso_vivienda_by_dpto_repository.dart';

class PisoViviendaByDptoUsecase {
  final PisoViviendaByDptoRepository repository;

  PisoViviendaByDptoUsecase(this.repository);

  Future<Either<Failure, List<PisoViviendaEntity>>>
      getPisosViviendaByDptoUsecase(int dtoId) {
    return repository.getPisosViviendaByDptoRepository(dtoId);
  }
}
