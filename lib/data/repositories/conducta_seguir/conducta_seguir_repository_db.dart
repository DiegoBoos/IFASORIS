import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/conducta_seguir_entity.dart';
import '../../../domain/repositories/conducta_seguir/conducta_seguir_repository_db.dart';
import '../../datasources/local/conducta_seguir_local_ds.dart';

class ConductaSeguirRepositoryDBImpl implements ConductaSeguirRepositoryDB {
  final ConductaSeguirLocalDataSource conductaSeguirLocalDataSource;

  ConductaSeguirRepositoryDBImpl({required this.conductaSeguirLocalDataSource});

  @override
  Future<Either<Failure, List<ConductaSeguirEntity>>>
      getConductasSeguirRepositoryDB() async {
    try {
      final result = await conductaSeguirLocalDataSource.getConductasSeguir();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveConductaSeguirRepositoryDB(
      ConductaSeguirEntity conductaSeguir) async {
    try {
      final result = await conductaSeguirLocalDataSource
          .saveConductaSeguir(conductaSeguir);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
