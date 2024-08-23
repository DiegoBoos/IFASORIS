import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/lugar_vacunacion.dart';
import '../../../domain/repositories/lugar_vacunacion/lugar_vacunacion_repository_db.dart';
import '../../datasources/local/lugar_vacunacion_local_ds.dart';
import '../../models/lugar_vacunacion.dart';

class LugarVacunacionRepositoryDBImpl implements LugarVacunacionRepositoryDB {
  final LugarVacunacionLocalDataSource lugarVacunacionLocalDataSource;

  LugarVacunacionRepositoryDBImpl(
      {required this.lugarVacunacionLocalDataSource});

  @override
  Future<Either<Failure, List<LugarVacunacionModel>>>
      getLugaresVacunacionRepositoryDB() async {
    try {
      final result =
          await lugarVacunacionLocalDataSource.getLugaresVacunacion();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveLugarVacunacionRepositoryDB(
      LugarVacunacionEntity lugarVacunacion) async {
    try {
      final lugarVacunacionModel =
          LugarVacunacionModel.fromEntity(lugarVacunacion);
      final result = await lugarVacunacionLocalDataSource
          .saveLugarVacunacion(lugarVacunacionModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
