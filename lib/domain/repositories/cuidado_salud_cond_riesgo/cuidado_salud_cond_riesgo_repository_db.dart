import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cuidado_salud_cond_riesgo_entity.dart';

abstract class CuidadoSaludCondRiesgoRepositoryDB {
  Future<Either<Failure, int>> saveCuidadoSaludCondRiesgoRepositoryDB(
      CuidadoSaludCondRiesgoEntity cuidadoSaludCondRiesgo);

  Future<Either<Failure, CuidadoSaludCondRiesgoEntity?>>
      getCuidadoSaludCondRiesgoRepositoryDB(int afiliadoId);
}
