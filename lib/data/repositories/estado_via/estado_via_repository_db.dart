import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/estado_via_entity.dart';
import '../../../domain/repositories/estado_via/estado_via_repository_db.dart';
import '../../datasources/local/estado_via_local_ds.dart';

class EstadoViaRepositoryDBImpl implements EstadoViaRepositoryDB {
  final EstadoViaLocalDataSource estadoViaLocalDataSource;

  EstadoViaRepositoryDBImpl({required this.estadoViaLocalDataSource});

  @override
  Future<Either<Failure, List<EstadoViaEntity>>>
      getEstadosViasRepositoryDB() async {
    try {
      final result = await estadoViaLocalDataSource.getEstadosVias();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEstadoViaRepositoryDB(
      EstadoViaEntity estadoVia) async {
    try {
      final result = await estadoViaLocalDataSource.saveEstadoVia(estadoVia);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
