import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nombre_lengua_maneja_entity.dart';
import '../../repositories/nombre_lengua_maneja/nombre_lengua_maneja_repository_db.dart';

class NombreLenguaManejaUsecaseDB {
  final NombreLenguaManejaRepositoryDB repositoryDB;

  NombreLenguaManejaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveNombreLenguaManejaUsecaseDB(
      NombreLenguaManejaEntity nombreLenguaManeja) {
    return repositoryDB.saveNombreLenguaManejaRepositoryDB(nombreLenguaManeja);
  }

  Future<Either<Failure, List<NombreLenguaManejaEntity>>>
      getNombresLenguasManejaUsecase() {
    return repositoryDB.getNombresLenguasManejaRepositoryDB();
  }
}
