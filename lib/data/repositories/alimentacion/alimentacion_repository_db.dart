import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';

import '../../../domain/entities/alimentacion.dart';
import '../../../domain/repositories/alimentacion/alimentacion_repository_db.dart';
import '../../datasources/local/alimentacion_local_ds.dart';
import '../../models/alimentacion.dart';

class AlimentacionRepositoryDBImpl implements AlimentacionRepositoryDB {
  final AlimentacionLocalDataSource alimentacionLocalDataSource;

  AlimentacionRepositoryDBImpl({required this.alimentacionLocalDataSource});

  @override
  Future<Either<Failure, List<AlimentacionModel>>>
      getAlimentacionesRepositoryDB() async {
    try {
      final result = await alimentacionLocalDataSource.getAlimentaciones();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAlimentacionRepositoryDB(
      AlimentacionEntity alimentacion) async {
    try {
      final alimentacionModel = AlimentacionModel.fromEntity(alimentacion);
      final result =
          await alimentacionLocalDataSource.saveAlimentacion(alimentacionModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
