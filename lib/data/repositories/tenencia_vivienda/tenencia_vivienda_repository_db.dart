import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tenencia_vivienda_entity.dart';
import '../../../domain/repositories/tenencia_vivienda/tenencia_vivienda_repository_db.dart';
import '../../datasources/local/tenencia_vivienda_local_ds.dart';

class TenenciaViviendaRepositoryDBImpl implements TenenciaViviendaRepositoryDB {
  final TenenciaViviendaLocalDataSource tenenciaViviendaLocalDataSource;

  TenenciaViviendaRepositoryDBImpl(
      {required this.tenenciaViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<TenenciaViviendaEntity>>>
      getTenenciasViviendaRepositoryDB() async {
    try {
      final result =
          await tenenciaViviendaLocalDataSource.getTenenciasVivienda();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTenenciaViviendaRepositoryDB(
      TenenciaViviendaEntity tenenciaVivienda) async {
    try {
      final result = await tenenciaViviendaLocalDataSource
          .saveTenenciaVivienda(tenenciaVivienda);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
