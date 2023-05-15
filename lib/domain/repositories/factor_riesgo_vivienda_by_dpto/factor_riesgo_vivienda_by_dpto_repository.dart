import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/factor_riesgo_vivienda_entity.dart';

abstract class FactorRiesgoViviendaByDptoRepository {
  Future<Either<Failure, List<FactorRiesgoViviendaEntity>>>
      getFactoresRiesgoViviendaByDptoRepository(int dtoId);
}
