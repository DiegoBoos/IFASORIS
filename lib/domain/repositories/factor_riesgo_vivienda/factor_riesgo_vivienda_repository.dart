import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/factor_riesgo_vivienda.dart';

abstract class FactorRiesgoViviendaRepository {
  Future<Either<Failure, List<FactorRiesgoViviendaEntity>>>
      getFactoresRiesgoViviendaRepository(int dtoId);
}
