import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/sancion_justicia_entity.dart';
import '../../repositories/sancion_justicia/sancion_justicia_repository_db.dart';

class SancionJusticiaUsecaseDB {
  final SancionJusticiaRepositoryDB repositoryDB;

  SancionJusticiaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveSancionJusticiaUsecaseDB(
      SancionJusticiaEntity sancionJusticia) {
    return repositoryDB.saveSancionJusticiaRepositoryDB(sancionJusticia);
  }

  Future<Either<Failure, List<SancionJusticiaEntity>>>
      getSancionesJusticiaUsecaseDB() {
    return repositoryDB.getSancionesJusticiaRepositoryDB();
  }
}
