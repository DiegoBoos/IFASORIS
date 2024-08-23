import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/conducta_seguir.dart';
import '../../../domain/repositories/conducta_seguir/conducta_seguir_repository_db.dart';
import '../../datasources/local/conducta_seguir_local_ds.dart';
import '../../models/conducta_seguir.dart';

class ConductaSeguirRepositoryDBImpl implements ConductaSeguirRepositoryDB {
  final ConductaSeguirLocalDataSource conductaSeguirLocalDataSource;

  ConductaSeguirRepositoryDBImpl({required this.conductaSeguirLocalDataSource});

  @override
  Future<Either<Failure, List<ConductaSeguirModel>>>
      getConductasSeguirRepositoryDB() async {
    try {
      final result = await conductaSeguirLocalDataSource.getConductasSeguir();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveConductaSeguirRepositoryDB(
      ConductaSeguirEntity conductaSeguir) async {
    try {
      final conductaSeguirModel =
          ConductaSeguirModel.fromEntity(conductaSeguir);
      final result = await conductaSeguirLocalDataSource
          .saveConductaSeguir(conductaSeguirModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
