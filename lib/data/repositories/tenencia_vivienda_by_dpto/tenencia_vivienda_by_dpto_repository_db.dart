import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tenencia_vivienda_entity.dart';
import '../../../domain/repositories/tenencia_vivienda_by_dpto/tenencia_vivienda_by_dpto_repository_db.dart';
import '../../datasources/local/tenencia_vivienda_by_dpto_local_ds.dart';

class TenenciaViviendaByDptoRepositoryDBImpl
    implements TenenciaViviendaByDptoRepositoryDB {
  final TenenciaViviendaByDptoLocalDataSource
      tenenciaViviendaByDptoLocalDataSource;

  TenenciaViviendaByDptoRepositoryDBImpl(
      {required this.tenenciaViviendaByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<TenenciaViviendaEntity>>>
      getTenenciasViviendaByDptoRepositoryDB() async {
    try {
      final result = await tenenciaViviendaByDptoLocalDataSource
          .getTenenciasViviendaByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTenenciaViviendaByDptoRepositoryDB(
      TenenciaViviendaEntity tenenciaVivienda) async {
    try {
      final result = await tenenciaViviendaByDptoLocalDataSource
          .saveTenenciaViviendaByDpto(tenenciaVivienda);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
