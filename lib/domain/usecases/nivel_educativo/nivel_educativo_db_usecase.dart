import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nivel_educativo.dart';
import '../../repositories/nivel_educativo/nivel_educativo_repository_db.dart';

class NivelEducativoUsecaseDB {
  final NivelEducativoRepositoryDB repositoryDB;

  NivelEducativoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveNivelEducativoUsecaseDB(
      NivelEducativoEntity nivelEducativo) {
    return repositoryDB.saveNivelEducativoRepositoryDB(nivelEducativo);
  }

  Future<Either<Failure, List<NivelEducativoEntity>>>
      getNivelesEducativosUsecase() {
    return repositoryDB.getNivelesEducativosRepositoryDB();
  }
}
