import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/leguminosa.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/leguminosa.dart';
import '../../../domain/repositories/leguminosa/leguminosa_repository_db.dart';
import '../../datasources/local/leguminosa_local_ds.dart';

class LeguminosaRepositoryDBImpl implements LeguminosaRepositoryDB {
  final LeguminosaLocalDataSource leguminosaLocalDataSource;

  LeguminosaRepositoryDBImpl({required this.leguminosaLocalDataSource});

  @override
  Future<Either<Failure, List<LeguminosaModel>>>
      getLeguminosasRepositoryDB() async {
    try {
      final result = await leguminosaLocalDataSource.getLeguminosas();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveLeguminosaRepositoryDB(
      LeguminosaEntity leguminosa) async {
    try {
      final leguminosaModel = LeguminosaModel.fromEntity(leguminosa);
      final result =
          await leguminosaLocalDataSource.saveLeguminosa(leguminosaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionLeguminosasRepositoryDB(
      int ubicacionId, List<LstLeguminosa> lstLeguminosas) async {
    try {
      final result = await leguminosaLocalDataSource.saveUbicacionLeguminosas(
          ubicacionId, lstLeguminosas);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstLeguminosa>>>
      getUbicacionLeguminosasRepositoryDB(int? ubicacionId) async {
    try {
      final result =
          await leguminosaLocalDataSource.getUbicacionLeguminosas(ubicacionId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
