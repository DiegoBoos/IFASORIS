import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/metodo_planificacion.dart';
import '../../../domain/repositories/metodo_planificacion/metodo_planificacion_repository_db.dart';
import '../../datasources/local/metodo_planificacion_local_ds.dart';
import '../../models/metodo_planificacion.dart';

class MetodoPlanificacionRepositoryDBImpl
    implements MetodoPlanificacionRepositoryDB {
  final MetodoPlanificacionLocalDataSource metodoPlanificacionLocalDataSource;

  MetodoPlanificacionRepositoryDBImpl(
      {required this.metodoPlanificacionLocalDataSource});

  @override
  Future<Either<Failure, List<MetodoPlanificacionModel>>>
      getMetodosPlanificacionRepositoryDB() async {
    try {
      final result =
          await metodoPlanificacionLocalDataSource.getMetodosPlanificacion();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveMetodoPlanificacionRepositoryDB(
      MetodoPlanificacionEntity metodoPlanificacion) async {
    try {
      final metodoPlanificacionModel =
          MetodoPlanificacionModel.fromEntity(metodoPlanificacion);
      final result = await metodoPlanificacionLocalDataSource
          .saveMetodoPlanificacion(metodoPlanificacionModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
