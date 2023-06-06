import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/hortaliza_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/hortaliza_entity.dart';
import '../../../domain/repositories/hortaliza_by_dpto/hortaliza_by_dpto_repository_db.dart';
import '../../datasources/local/hortaliza_by_dpto_local_ds.dart';

class HortalizaByDptoRepositoryDBImpl implements HortalizaByDptoRepositoryDB {
  final HortalizaByDptoLocalDataSource hortalizaByDptoLocalDataSource;

  HortalizaByDptoRepositoryDBImpl(
      {required this.hortalizaByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<HortalizaEntity>>>
      getHortalizasByDptoRepositoryDB() async {
    try {
      final result = await hortalizaByDptoLocalDataSource.getHortalizasByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveHortalizaByDptoRepositoryDB(
      HortalizaEntity hortaliza) async {
    try {
      final result =
          await hortalizaByDptoLocalDataSource.saveHortalizaByDpto(hortaliza);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionHortalizasRepositoryDB(
      int ubicacionId, List<LstHortaliza> lstHortalizas) async {
    try {
      final result = await hortalizaByDptoLocalDataSource
          .saveUbicacionHortalizas(ubicacionId, lstHortalizas);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstHortaliza>>>
      getUbicacionHortalizasRepositoryDB(int? ubicacionId) async {
    try {
      final result = await hortalizaByDptoLocalDataSource
          .getUbicacionHortalizas(ubicacionId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
