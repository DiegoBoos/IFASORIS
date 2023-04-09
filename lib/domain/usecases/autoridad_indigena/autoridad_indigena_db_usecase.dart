import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/autoridad_indigena_entity.dart';
import '../../repositories/autoridad_indigena/autoridad_indigena_repository_db.dart';

class AutoridadIndigenaUsecaseDB {
  final AutoridadIndigenaRepositoryDB repositoryDB;

  AutoridadIndigenaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveAutoridadIndigenaUsecaseDB(
      AutoridadIndigenaEntity autoridadeIndigena) {
    return repositoryDB.saveAutoridadIndigenaRepositoryDB(autoridadeIndigena);
  }

  Future<Either<Failure, List<AutoridadIndigenaEntity>>>
      getAutoridadesIndigenasUsecaseDB() {
    return repositoryDB.getAutoridadesIndigenasRepositoryDB();
  }
}
