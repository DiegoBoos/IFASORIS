import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/cereal.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/cereal.dart';
import '../../../domain/repositories/cereal/cereal_repository_db.dart';
import '../../datasources/local/cereal_local_ds.dart';

class CerealRepositoryDBImpl implements CerealRepositoryDB {
  final CerealLocalDataSource cerealLocalDataSource;

  CerealRepositoryDBImpl({required this.cerealLocalDataSource});

  @override
  Future<Either<Failure, List<CerealModel>>> getCerealesRepositoryDB() async {
    try {
      final result = await cerealLocalDataSource.getCereales();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveCerealRepositoryDB(
      CerealEntity cereal) async {
    try {
      final cerealModel = CerealModel.fromEntity(cereal);
      final result = await cerealLocalDataSource.saveCereal(cerealModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionCerealesRepositoryDB(
      int ubicacionId, List<LstCereal> lstCereales) async {
    try {
      final result = await cerealLocalDataSource.saveUbicacionCereales(
          ubicacionId, lstCereales);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<LstCereal>>> getUbicacionCerealesRepositoryDB(
      int? ubicacionId) async {
    try {
      final result =
          await cerealLocalDataSource.getUbicacionCereales(ubicacionId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
