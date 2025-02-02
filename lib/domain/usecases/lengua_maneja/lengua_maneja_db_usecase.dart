import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lengua_maneja.dart';
import '../../repositories/lengua_maneja/lengua_maneja_repository_db.dart';

class LenguaManejaUsecaseDB {
  final LenguaManejaRepositoryDB repositoryDB;

  LenguaManejaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveLenguaManejaUsecaseDB(
      LenguaManejaEntity lenguaManeja) {
    return repositoryDB.saveLenguaManejaRepositoryDB(lenguaManeja);
  }

  Future<Either<Failure, List<LenguaManejaEntity>>> getLenguasManejaUsecase() {
    return repositoryDB.getLenguasManejaRepositoryDB();
  }
}
