import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/actividad_fisica_entity.dart';
import '../../../domain/repositories/actividad_fisica/actividad_fisica_repository_db.dart';
import '../../datasources/local/actividad_fisica_local_ds.dart';

class ActividadFisicaRepositoryDBImpl implements ActividadFisicaRepositoryDB {
  final ActividadFisicaLocalDataSource actividadFisicaLocalDataSource;

  ActividadFisicaRepositoryDBImpl(
      {required this.actividadFisicaLocalDataSource});

  @override
  Future<Either<Failure, List<ActividadFisicaEntity>>>
      getActividadesFisicasRepositoryDB() async {
    try {
      final result =
          await actividadFisicaLocalDataSource.getActividadesFisicas();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveActividadFisicaRepositoryDB(
      ActividadFisicaEntity actividadFisica) async {
    try {
      final result = await actividadFisicaLocalDataSource
          .saveActividadFisica(actividadFisica);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
