import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nombre_lengua_materna_entity.dart';
import '../../repositories/nombre_lengua_materna/nombre_lengua_materna_repository_db.dart';

class NombreLenguaMaternaUsecaseDB {
  final NombreLenguaMaternaRepositoryDB repositoryDB;

  NombreLenguaMaternaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveNombreLenguaMaternaUsecaseDB(
      NombreLenguaMaternaEntity nombreLenguaMaterna) {
    return repositoryDB
        .saveNombreLenguaMaternaRepositoryDB(nombreLenguaMaterna);
  }

  Future<Either<Failure, List<NombreLenguaMaternaEntity>>>
      getNombresLenguasMaternaUsecase() {
    return repositoryDB.getNombresLenguasMaternaRepositoryDB();
  }
}
