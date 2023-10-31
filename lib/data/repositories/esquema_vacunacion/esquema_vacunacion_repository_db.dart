import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/esquema_vacunacion_entity.dart';
import '../../../domain/repositories/esquema_vacunacion/esquema_vacunacion_repository_db.dart';
import '../../datasources/local/esquema_vacunacion_local_ds.dart';

class EsquemaVacunacionRepositoryDBImpl
    implements EsquemaVacunacionRepositoryDB {
  final EsquemaVacunacionLocalDataSource esquemaVacunacionLocalDataSource;

  EsquemaVacunacionRepositoryDBImpl(
      {required this.esquemaVacunacionLocalDataSource});

  @override
  Future<Either<Failure, List<EsquemaVacunacionEntity>>>
      getEsquemasVacunacionRepositoryDB() async {
    try {
      final result =
          await esquemaVacunacionLocalDataSource.getEsquemasVacunacion();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEsquemaVacunacionRepositoryDB(
      EsquemaVacunacionEntity esquemaVacunacion) async {
    try {
      final result = await esquemaVacunacionLocalDataSource
          .saveEsquemaVacunacion(esquemaVacunacion);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
