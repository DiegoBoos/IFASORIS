import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/tenencia_vivienda.dart';
import '../../../domain/repositories/tenencia_vivienda/tenencia_vivienda_repository_db.dart';
import '../../datasources/local/tenencia_vivienda_local_ds.dart';
import '../../models/tenencia_vivienda.dart';

class TenenciaViviendaRepositoryDBImpl implements TenenciaViviendaRepositoryDB {
  final TenenciaViviendaLocalDataSource tenenciaViviendaLocalDataSource;

  TenenciaViviendaRepositoryDBImpl(
      {required this.tenenciaViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<TenenciaViviendaModel>>>
      getTenenciasViviendaRepositoryDB() async {
    try {
      final result =
          await tenenciaViviendaLocalDataSource.getTenenciasVivienda();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTenenciaViviendaRepositoryDB(
      TenenciaViviendaEntity tenenciaVivienda) async {
    try {
      final tenenciaViviendaModel =
          TenenciaViviendaModel.fromEntity(tenenciaVivienda);
      final result = await tenenciaViviendaLocalDataSource
          .saveTenenciaVivienda(tenenciaViviendaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
