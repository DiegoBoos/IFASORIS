import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/usecases/actividad_fisica/actividad_fisica_exports.dart';
import '../../models/actividad_fisica.dart';

class ActividadFisicaRepositoryDBImpl implements ActividadFisicaRepositoryDB {
  final ActividadFisicaLocalDataSource actividadFisicaLocalDataSource;

  ActividadFisicaRepositoryDBImpl(
      {required this.actividadFisicaLocalDataSource});

  @override
  Future<Either<Failure, List<ActividadFisicaModel>>>
      getActividadesFisicasRepositoryDB() async {
    try {
      final result =
          await actividadFisicaLocalDataSource.getActividadesFisicas();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveActividadFisicaRepositoryDB(
      ActividadFisicaEntity actividadFisica) async {
    try {
      final actividadFisicaModel =
          ActividadFisicaModel.fromEntity(actividadFisica);

      final result = await actividadFisicaLocalDataSource
          .saveActividadFisica(actividadFisicaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
