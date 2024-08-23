import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/esquema_vacunacion.dart';
import '../../../domain/repositories/esquema_vacunacion/esquema_vacunacion_repository_db.dart';
import '../../datasources/local/esquema_vacunacion_local_ds.dart';
import '../../models/esquema_vacunacion.dart';

class EsquemaVacunacionRepositoryDBImpl
    implements EsquemaVacunacionRepositoryDB {
  final EsquemaVacunacionLocalDataSource esquemaVacunacionLocalDataSource;

  EsquemaVacunacionRepositoryDBImpl(
      {required this.esquemaVacunacionLocalDataSource});

  @override
  Future<Either<Failure, List<EsquemaVacunacionModel>>>
      getEsquemasVacunacionRepositoryDB() async {
    try {
      final result =
          await esquemaVacunacionLocalDataSource.getEsquemasVacunacion();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveEsquemaVacunacionRepositoryDB(
      EsquemaVacunacionEntity esquemaVacunacion) async {
    try {
      final esquemaVacunacionModel =
          EsquemaVacunacionModel.fromEntity(esquemaVacunacion);
      final result = await esquemaVacunacionLocalDataSource
          .saveEsquemaVacunacion(esquemaVacunacionModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
