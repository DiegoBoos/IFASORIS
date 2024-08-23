import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/hortaliza.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/hortaliza.dart';
import '../../../domain/repositories/hortaliza/hortaliza_repository_db.dart';
import '../../datasources/local/hortaliza_local_ds.dart';

class HortalizaRepositoryDBImpl implements HortalizaRepositoryDB {
  final HortalizaLocalDataSource hortalizaLocalDataSource;

  HortalizaRepositoryDBImpl({required this.hortalizaLocalDataSource});

  @override
  Future<Either<Failure, List<HortalizaModel>>>
      getHortalizasRepositoryDB() async {
    try {
      final result = await hortalizaLocalDataSource.getHortalizas();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveHortalizaRepositoryDB(
      HortalizaEntity hortaliza) async {
    try {
      final hortalizaModel = HortalizaModel.fromEntity(hortaliza);
      final result =
          await hortalizaLocalDataSource.saveHortaliza(hortalizaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionHortalizasRepositoryDB(
      int ubicacionId, List<LstHortaliza> lstHortalizas) async {
    try {
      final result = await hortalizaLocalDataSource.saveUbicacionHortalizas(
          ubicacionId, lstHortalizas);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<LstHortaliza>>>
      getUbicacionHortalizasRepositoryDB(int? ubicacionId) async {
    try {
      final result =
          await hortalizaLocalDataSource.getUbicacionHortalizas(ubicacionId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
