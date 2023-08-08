import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/fruto_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/fruto_entity.dart';
import '../../../domain/repositories/fruto/fruto_repository_db.dart';
import '../../datasources/local/fruto_local_ds.dart';

class FrutoRepositoryDBImpl implements FrutoRepositoryDB {
  final FrutoLocalDataSource frutoLocalDataSource;

  FrutoRepositoryDBImpl({required this.frutoLocalDataSource});

  @override
  Future<Either<Failure, List<FrutoEntity>>> getFrutosRepositoryDB() async {
    try {
      final result = await frutoLocalDataSource.getFrutos();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveFrutoRepositoryDB(FrutoEntity fruto) async {
    try {
      final result = await frutoLocalDataSource.saveFruto(fruto);
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
      final result = await frutoLocalDataSource.saveUbicacionFrutos(
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
      final result = await frutoLocalDataSource.getUbicacionFrutos(ubicacionId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
