import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/factor_riesgo_vivienda_entity.dart';
import '../../repositories/factor_riesgo_vivienda/factor_riesgo_vivienda_repository.dart';

class FactorRiesgoViviendaUsecase {
  final FactorRiesgoViviendaRepository repository;

  FactorRiesgoViviendaUsecase(this.repository);

  Future<Either<Failure, List<FactorRiesgoViviendaEntity>>>
      getFactoresRiesgoViviendaUsecase(int dtoId) {
    return repository.getFactoresRiesgoViviendaRepository(dtoId);
  }
}
