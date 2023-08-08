import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/cereal_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/cereal_entity.dart';
import '../../../domain/repositories/cereal/cereal_repository_db.dart';
import '../../datasources/local/cereal_local_ds.dart';

class CerealRepositoryDBImpl implements CerealRepositoryDB {
  final CerealLocalDataSource cerealLocalDataSource;

  CerealRepositoryDBImpl({required this.cerealLocalDataSource});

  @override
  Future<Either<Failure, List<CerealEntity>>> getCerealesRepositoryDB() async {
    try {
      final result = await cerealLocalDataSource.getCereales();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveCerealRepositoryDB(
      CerealEntity cereal) async {
    try {
      final result = await cerealLocalDataSource.saveCereal(cereal);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionCerealesRepositoryDB(
      int ubicacionId, List<LstCereal> lstCereales) async {
    try {
      final result = await cerealLocalDataSource.saveUbicacionCereales(
          ubicacionId, lstCereales);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstCereal>>> getUbicacionCerealesRepositoryDB(
      int? ubicacionId) async {
    try {
      final result =
          await cerealLocalDataSource.getUbicacionCereales(ubicacionId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
