import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/lugar_vacunacion_entity.dart';
import '../../../domain/repositories/lugar_vacunacion/lugar_vacunacion_repository_db.dart';
import '../../datasources/local/lugar_vacunacion_local_ds.dart';

class LugarVacunacionRepositoryDBImpl implements LugarVacunacionRepositoryDB {
  final LugarVacunacionLocalDataSource lugarVacunacionLocalDataSource;

  LugarVacunacionRepositoryDBImpl(
      {required this.lugarVacunacionLocalDataSource});

  @override
  Future<Either<Failure, List<LugarVacunacionEntity>>>
      getLugaresVacunacionRepositoryDB() async {
    try {
      final result =
          await lugarVacunacionLocalDataSource.getLugaresVacunacion();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveLugarVacunacionRepositoryDB(
      LugarVacunacionEntity lugarVacunacion) async {
    try {
      final result = await lugarVacunacionLocalDataSource
          .saveLugarVacunacion(lugarVacunacion);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
