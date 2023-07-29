import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/religion_profesa_entity.dart';
import '../../repositories/religion_profesa/religion_profesa_repository_db.dart';

class ReligionProfesaUsecaseDB {
  final ReligionProfesaRepositoryDB repositoryDB;

  ReligionProfesaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveReligionProfesaUsecaseDB(
      ReligionProfesaEntity religionProfesa) {
    return repositoryDB.saveReligionProfesaRepositoryDB(religionProfesa);
  }

  Future<Either<Failure, List<ReligionProfesaEntity>>>
      getReligionesProfesaUsecaseDB() {
    return repositoryDB.getReligionesProfesaRepositoryDB();
  }
}
