import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/factor_riesgo_vivienda_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/factor_riesgo_vivienda_entity.dart';
import '../../../domain/repositories/factor_riesgo_vivienda/factor_riesgo_vivienda_repository_db.dart';
import '../../datasources/local/factor_riesgo_vivienda_local_ds.dart';

class FactorRiesgoViviendaRepositoryDBImpl
    implements FactorRiesgoViviendaRepositoryDB {
  final FactorRiesgoViviendaLocalDataSource factorRiesgoViviendaLocalDataSource;

  FactorRiesgoViviendaRepositoryDBImpl(
      {required this.factorRiesgoViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<FactorRiesgoViviendaEntity>>>
      getFactoresRiesgoRepositoryDB() async {
    try {
      final result =
          await factorRiesgoViviendaLocalDataSource.getFactoresRiesgo();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveFactorRiesgoViviendaRepositoryDB(
      FactorRiesgoViviendaEntity factorRiesgoVivienda) async {
    try {
      final result = await factorRiesgoViviendaLocalDataSource
          .saveFactorRiesgoVivienda(factorRiesgoVivienda);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveFactoresRiesgoViviendaRepositoryDB(
      int datoViviendaId, List<LstFactorRiesgo> lstFactorRiesgo) async {
    try {
      final result = await factorRiesgoViviendaLocalDataSource
          .saveFactoresRiesgoVivienda(datoViviendaId, lstFactorRiesgo);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstFactorRiesgo>>>
      getFactoresRiesgoViviendaRepositoryDB(int? datoViviendaId) async {
    try {
      final result = await factorRiesgoViviendaLocalDataSource
          .getFactoresRiesgoVivienda(datoViviendaId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
