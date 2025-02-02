import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/esquema_vacunacion.dart';
import '../../repositories/esquema_vacunacion/esquema_vacunacion_repository_db.dart';

class EsquemaVacunacionUsecaseDB {
  final EsquemaVacunacionRepositoryDB repositoryDB;

  EsquemaVacunacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveEsquemaVacunacionUsecaseDB(
      EsquemaVacunacionEntity esquemaVacunacion) {
    return repositoryDB.saveEsquemaVacunacionRepositoryDB(esquemaVacunacion);
  }

  Future<Either<Failure, List<EsquemaVacunacionEntity>>>
      getEsquemasVacunacionUsecaseDB() {
    return repositoryDB.getEsquemasVacunacionRepositoryDB();
  }
}
