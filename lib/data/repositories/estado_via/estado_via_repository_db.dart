import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/estado_via.dart';
import '../../../domain/repositories/estado_via/estado_via_repository_db.dart';
import '../../datasources/local/estado_via_local_ds.dart';
import '../../models/estado_via.dart';

class EstadoViaRepositoryDBImpl implements EstadoViaRepositoryDB {
  final EstadoViaLocalDataSource estadoViaLocalDataSource;

  EstadoViaRepositoryDBImpl({required this.estadoViaLocalDataSource});

  @override
  Future<Either<Failure, List<EstadoViaModel>>>
      getEstadosViasRepositoryDB() async {
    try {
      final result = await estadoViaLocalDataSource.getEstadosVias();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveEstadoViaRepositoryDB(
      EstadoViaEntity estadoVia) async {
    try {
      final estadoViaModel = EstadoViaModel.fromEntity(estadoVia);
      final result =
          await estadoViaLocalDataSource.saveEstadoVia(estadoViaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
