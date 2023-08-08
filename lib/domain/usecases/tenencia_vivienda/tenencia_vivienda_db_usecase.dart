import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tenencia_vivienda_entity.dart';
import '../../repositories/tenencia_vivienda/tenencia_vivienda_repository_db.dart';

class TenenciaViviendaUsecaseDB {
  final TenenciaViviendaRepositoryDB repositoryDB;

  TenenciaViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTenenciaViviendaUsecaseDB(
      TenenciaViviendaEntity tenenciaVivienda) {
    return repositoryDB.saveTenenciaViviendaRepositoryDB(tenenciaVivienda);
  }

  Future<Either<Failure, List<TenenciaViviendaEntity>>>
      getTenenciasViviendaUsecaseDB() {
    return repositoryDB.getTenenciasViviendaRepositoryDB();
  }
}
