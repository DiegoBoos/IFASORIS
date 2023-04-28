import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ficha_entity.dart';
import '../../repositories/ficha/ficha_repository_db.dart';

class FichaUsecaseDB {
  final FichaRepositoryDB repositoryDB;

  FichaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, FichaEntity>> createFichaUsecaseDB(FichaEntity ficha) {
    return repositoryDB.createFichaRepositoryDB(ficha);
  }

  Future<Either<Failure, List<FichaEntity>>> loadFichasUsecaseDB() {
    return repositoryDB.loadFichasRepositoryDB();
  }
}
