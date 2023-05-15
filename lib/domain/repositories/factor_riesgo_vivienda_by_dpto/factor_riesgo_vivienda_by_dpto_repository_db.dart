import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/factor_riesgo_vivienda_entity.dart';

abstract class FactorRiesgoViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveFactorRiesgoViviendaByDptoRepositoryDB(
      FactorRiesgoViviendaEntity factorRiesgoVivienda);

  Future<Either<Failure, List<FactorRiesgoViviendaEntity>>>
      getFactoresRiesgoViviendaByDptoRepositoryDB();
}
