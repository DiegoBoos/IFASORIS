import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/factor_riesgo_vivienda_entity.dart';
import '../../repositories/factor_riesgo_vivienda_by_dpto/factor_riesgo_vivienda_by_dpto_repository.dart';

class FactorRiesgoViviendaByDptoUsecase {
  final FactorRiesgoViviendaByDptoRepository repository;

  FactorRiesgoViviendaByDptoUsecase(this.repository);

  Future<Either<Failure, List<FactorRiesgoViviendaEntity>>>
      getFactoresRiesgoViviendaByDptoUsecase(int dtoId) {
    return repository.getFactoresRiesgoViviendaByDptoRepository(dtoId);
  }
}
