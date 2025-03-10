import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tipo_combustible_vivienda_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_combustible_vivienda_entity.dart';
import '../../../domain/repositories/tipo_combustible_vivienda/tipo_combustible_vivienda_repository_db.dart';
import '../../datasources/local/tipo_combustible_vivienda_local_ds.dart';

class TipoCombustibleViviendaRepositoryDBImpl
    implements TipoCombustibleViviendaRepositoryDB {
  final TipoCombustibleViviendaLocalDataSource
      tipoCombustibleViviendaLocalDataSource;

  TipoCombustibleViviendaRepositoryDBImpl(
      {required this.tipoCombustibleViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<TipoCombustibleViviendaEntity>>>
      getTiposCombustibleRepositoryDB() async {
    try {
      final result =
          await tipoCombustibleViviendaLocalDataSource.getTiposCombustible();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTipoCombustibleViviendaRepositoryDB(
      TipoCombustibleViviendaEntity tipoCombustibleVivienda) async {
    try {
      final result = await tipoCombustibleViviendaLocalDataSource
          .saveTipoCombustibleVivienda(tipoCombustibleVivienda);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiposCombustibleViviendaRepositoryDB(
      int datoViviendaId, List<LstTipoCombustible> lstTipoCombustible) async {
    try {
      final result = await tipoCombustibleViviendaLocalDataSource
          .saveTiposCombustibleVivienda(datoViviendaId, lstTipoCombustible);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstTipoCombustible>>>
      getTiposCombustibleViviendaRepositoryDB(int? datoViviendaId) async {
    try {
      final result = await tipoCombustibleViviendaLocalDataSource
          .getTiposCombustibleVivienda(datoViviendaId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
