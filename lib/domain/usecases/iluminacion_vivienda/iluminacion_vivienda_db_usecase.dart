import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/iluminacion_vivienda_entity.dart';
import '../../repositories/iluminacion_vivienda/iluminacion_vivienda_repository_db.dart';

class IluminacionViviendaUsecaseDB {
  final IluminacionViviendaRepositoryDB repositoryDB;

  IluminacionViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveIluminacionViviendaUsecaseDB(
      IluminacionViviendaEntity iluminacionVivienda) {
    return repositoryDB
        .saveIluminacionViviendaRepositoryDB(iluminacionVivienda);
  }

  Future<Either<Failure, List<IluminacionViviendaEntity>>>
      getIluminacionesViviendaUsecaseDB() {
    return repositoryDB.getIluminacionesViviendaRepositoryDB();
  }
}
