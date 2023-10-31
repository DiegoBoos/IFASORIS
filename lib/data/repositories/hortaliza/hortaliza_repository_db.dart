import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/hortaliza_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/hortaliza_entity.dart';
import '../../../domain/repositories/hortaliza/hortaliza_repository_db.dart';
import '../../datasources/local/hortaliza_local_ds.dart';

class HortalizaRepositoryDBImpl implements HortalizaRepositoryDB {
  final HortalizaLocalDataSource hortalizaLocalDataSource;

  HortalizaRepositoryDBImpl({required this.hortalizaLocalDataSource});

  @override
  Future<Either<Failure, List<HortalizaEntity>>>
      getHortalizasRepositoryDB() async {
    try {
      final result = await hortalizaLocalDataSource.getHortalizas();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveHortalizaRepositoryDB(
      HortalizaEntity hortaliza) async {
    try {
      final result = await hortalizaLocalDataSource.saveHortaliza(hortaliza);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
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
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
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
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
