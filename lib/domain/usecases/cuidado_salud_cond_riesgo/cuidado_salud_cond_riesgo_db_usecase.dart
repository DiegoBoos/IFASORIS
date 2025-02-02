import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cuidado_salud_cond_riesgo.dart';
import '../../repositories/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_repository_db.dart';

class CuidadoSaludCondRiesgoUsecaseDB {
  final CuidadoSaludCondRiesgoRepositoryDB repositoryDB;

  CuidadoSaludCondRiesgoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveCuidadoSaludCondRiesgoUsecaseDB(
      CuidadoSaludCondRiesgoEntity cuidadoSaludCondRiesgo) {
    return repositoryDB
        .saveCuidadoSaludCondRiesgoRepositoryDB(cuidadoSaludCondRiesgo);
  }

  Future<Either<Failure, CuidadoSaludCondRiesgoEntity?>>
      getCuidadoSaludCondRiesgoUsecaseDB(int afiliadoId) {
    return repositoryDB.getCuidadoSaludCondRiesgoRepositoryDB(afiliadoId);
  }
}
