import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/factor_riesgo_vivienda_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/factor_riesgo_vivienda_entity.dart';
import '../../../domain/repositories/factor_riesgo_vivienda_by_dpto/factor_riesgo_vivienda_by_dpto_repository_db.dart';
import '../../datasources/local/factor_riesgo_vivienda_by_dpto_local_ds.dart';

class FactorRiesgoViviendaByDptoRepositoryDBImpl
    implements FactorRiesgoViviendaByDptoRepositoryDB {
  final FactorRiesgoViviendaByDptoLocalDataSource
      factorRiesgoViviendaByDptoLocalDataSource;

  FactorRiesgoViviendaByDptoRepositoryDBImpl(
      {required this.factorRiesgoViviendaByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<FactorRiesgoViviendaEntity>>>
      getFactoresRiesgoViviendaByDptoRepositoryDB() async {
    try {
      final result = await factorRiesgoViviendaByDptoLocalDataSource
          .getFactoresRiesgoViviendaByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveFactorRiesgoViviendaByDptoRepositoryDB(
      FactorRiesgoViviendaEntity factorRiesgoViviendaByDpto) async {
    try {
      final result = await factorRiesgoViviendaByDptoLocalDataSource
          .saveFactorRiesgoViviendaByDpto(factorRiesgoViviendaByDpto);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveFactoresRiesgoViviendaRepositoryDB(
      int datoViviendaId, List<LstFactoresRiesgo> lstFactoresRiesgo) async {
    try {
      final result = await factorRiesgoViviendaByDptoLocalDataSource
          .saveFactoresRiesgoVivienda(datoViviendaId, lstFactoresRiesgo);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstFactoresRiesgo>>>
      getFactoresRiesgoViviendaRepositoryDB(int? datoViviendaId) async {
    try {
      final result = await factorRiesgoViviendaByDptoLocalDataSource
          .getFactoresRiesgoVivienda(datoViviendaId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
