import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/cereal_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/cereal_entity.dart';
import '../../../domain/repositories/cereal_by_dpto/cereal_by_dpto_repository_db.dart';
import '../../datasources/local/cereal_by_dpto_local_ds.dart';

class CerealByDptoRepositoryDBImpl implements CerealByDptoRepositoryDB {
  final CerealByDptoLocalDataSource cerealByDptoLocalDataSource;

  CerealByDptoRepositoryDBImpl({required this.cerealByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<CerealEntity>>>
      getCerealesByDptoRepositoryDB() async {
    try {
      final result = await cerealByDptoLocalDataSource.getCerealesByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveCerealByDptoRepositoryDB(
      CerealEntity cereal) async {
    try {
      final result = await cerealByDptoLocalDataSource.saveCerealByDpto(cereal);
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
      final result = await cerealByDptoLocalDataSource.saveUbicacionCereales(
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
          await cerealByDptoLocalDataSource.getUbicacionCereales(ubicacionId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
