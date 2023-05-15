import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tenencia_vivienda_entity.dart';
import '../../repositories/tenencia_vivienda_by_dpto/tenencia_vivienda_by_dpto_repository_db.dart';

class TenenciaViviendaByDptoUsecaseDB {
  final TenenciaViviendaByDptoRepositoryDB repositoryDB;

  TenenciaViviendaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTenenciaViviendaByDptoUsecaseDB(
      TenenciaViviendaEntity tenenciaVivienda) {
    return repositoryDB
        .saveTenenciaViviendaByDptoRepositoryDB(tenenciaVivienda);
  }

  Future<Either<Failure, List<TenenciaViviendaEntity>>>
      getTenenciasViviendaByDptoUsecaseDB() {
    return repositoryDB.getTenenciasViviendaByDptoRepositoryDB();
  }
}
