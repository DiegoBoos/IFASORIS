import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/techo_vivienda_entity.dart';
import '../../repositories/techo_vivienda_by_dpto/techo_vivienda_by_dpto_repository.dart';

class TechoViviendaByDptoUsecase {
  final TechoViviendaByDptoRepository repository;

  TechoViviendaByDptoUsecase(this.repository);

  Future<Either<Failure, List<TechoViviendaEntity>>>
      getTechosViviendaByDptoUsecase(int dtoId) {
    return repository.getTechosViviendaByDptoRepository(dtoId);
  }
}
