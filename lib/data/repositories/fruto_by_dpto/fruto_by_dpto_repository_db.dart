import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/fruto_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/fruto_entity.dart';
import '../../../domain/repositories/fruto_by_dpto/fruto_by_dpto_repository_db.dart';
import '../../datasources/local/fruto_by_dpto_local_ds.dart';

class FrutoByDptoRepositoryDBImpl implements FrutoByDptoRepositoryDB {
  final FrutoByDptoLocalDataSource frutoByDptoLocalDataSource;

  FrutoByDptoRepositoryDBImpl({required this.frutoByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<FrutoEntity>>>
      getFrutosByDptoRepositoryDB() async {
    try {
      final result = await frutoByDptoLocalDataSource.getFrutosByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveFrutoByDptoRepositoryDB(
      FrutoEntity fruto) async {
    try {
      final result = await frutoByDptoLocalDataSource.saveFrutoByDpto(fruto);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionFrutosRepositoryDB(
      int ubicacionId, List<LstFruto> lstFrutos) async {
    try {
      final result = await frutoByDptoLocalDataSource.saveUbicacionFrutos(
          ubicacionId, lstFrutos);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstFruto>>> getUbicacionFrutosRepositoryDB(
      int? ubicacionId) async {
    try {
      final result =
          await frutoByDptoLocalDataSource.getUbicacionFrutos(ubicacionId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
