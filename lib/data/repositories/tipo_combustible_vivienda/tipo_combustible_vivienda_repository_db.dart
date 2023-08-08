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
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTipoCombustibleViviendaRepositoryDB(
      TipoCombustibleViviendaEntity tipoCombustibleVivienda) async {
    try {
      final result = await tipoCombustibleViviendaLocalDataSource
          .saveTipoCombustibleVivienda(tipoCombustibleVivienda);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiposCombustibleViviendaRepositoryDB(
      int datoViviendaId, List<LstTiposCombustible> lstTiposCombustible) async {
    try {
      final result = await tipoCombustibleViviendaLocalDataSource
          .saveTiposCombustibleVivienda(datoViviendaId, lstTiposCombustible);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstTiposCombustible>>>
      getTiposCombustibleViviendaRepositoryDB(int? datoViviendaId) async {
    try {
      final result = await tipoCombustibleViviendaLocalDataSource
          .getTiposCombustibleVivienda(datoViviendaId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
