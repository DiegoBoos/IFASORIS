import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/fruto.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/fruto.dart';
import '../../../domain/repositories/fruto/fruto_repository_db.dart';
import '../../datasources/local/fruto_local_ds.dart';

class FrutoRepositoryDBImpl implements FrutoRepositoryDB {
  final FrutoLocalDataSource frutoLocalDataSource;

  FrutoRepositoryDBImpl({required this.frutoLocalDataSource});

  @override
  Future<Either<Failure, List<FrutoModel>>> getFrutosRepositoryDB() async {
    try {
      final result = await frutoLocalDataSource.getFrutos();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveFrutoRepositoryDB(FrutoEntity fruto) async {
    try {
      final frutoModel = FrutoModel.fromEntity(fruto);
      final result = await frutoLocalDataSource.saveFruto(frutoModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionFrutosRepositoryDB(
      int ubicacionId, List<LstFruto> lstFrutos) async {
    try {
      final result = await frutoLocalDataSource.saveUbicacionFrutos(
          ubicacionId, lstFrutos);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<LstFruto>>> getUbicacionFrutosRepositoryDB(
      int? ubicacionId) async {
    try {
      final result = await frutoLocalDataSource.getUbicacionFrutos(ubicacionId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
