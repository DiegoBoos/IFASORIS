import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/resguardo.dart';
import '../../repositories/resguardo/resguardo_repository_db.dart';

class ResguardoUsecaseDB {
  final ResguardoRepositoryDB repositoryDB;

  ResguardoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveResguardoUsecaseDB(
      ResguardoEntity resguardo) {
    return repositoryDB.saveResguardoRepositoryDB(resguardo);
  }

  Future<Either<Failure, List<ResguardoEntity>>> getResguardosUsecaseDB() {
    return repositoryDB.getResguardosRepositoryDB();
  }
}
