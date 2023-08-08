import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/leguminosa_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/leguminosa_entity.dart';
import '../../../domain/repositories/leguminosa/leguminosa_repository_db.dart';
import '../../datasources/local/leguminosa_local_ds.dart';

class LeguminosaRepositoryDBImpl implements LeguminosaRepositoryDB {
  final LeguminosaLocalDataSource leguminosaLocalDataSource;

  LeguminosaRepositoryDBImpl({required this.leguminosaLocalDataSource});

  @override
  Future<Either<Failure, List<LeguminosaEntity>>>
      getLeguminosasRepositoryDB() async {
    try {
      final result = await leguminosaLocalDataSource.getLeguminosas();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveLeguminosaRepositoryDB(
      LeguminosaEntity leguminosa) async {
    try {
      final result = await leguminosaLocalDataSource.saveLeguminosa(leguminosa);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionLeguminosasRepositoryDB(
      int ubicacionId, List<LstLeguminosa> lstLeguminosas) async {
    try {
      final result = await leguminosaLocalDataSource.saveUbicacionLeguminosas(
          ubicacionId, lstLeguminosas);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstLeguminosa>>>
      getUbicacionLeguminosasRepositoryDB(int? ubicacionId) async {
    try {
      final result =
          await leguminosaLocalDataSource.getUbicacionLeguminosas(ubicacionId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
