import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/enfermedad_acude.dart';
import '../../repositories/enfermedad_acude/enfermedad_acude_repository_db.dart';

class EnfermedadAcudeUsecaseDB {
  final EnfermedadAcudeRepositoryDB repositoryDB;

  EnfermedadAcudeUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveEnfermedadAcudeUsecaseDB(
      EnfermedadAcudeEntity enfermedadAcude) {
    return repositoryDB.saveEnfermedadAcudeRepositoryDB(enfermedadAcude);
  }

  Future<Either<Failure, List<EnfermedadAcudeEntity>>>
      getEnfermedadesAcudeUsecaseDB() {
    return repositoryDB.getEnfermedadesAcudeRepositoryDB();
  }
}
