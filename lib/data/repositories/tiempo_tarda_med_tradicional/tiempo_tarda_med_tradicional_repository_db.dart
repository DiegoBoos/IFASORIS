import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tiempo_tarda_med_tradicional_entity.dart';
import '../../../domain/repositories/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_repository_db.dart';
import '../../datasources/local/tiempo_tarda_med_tradicional_local_ds.dart';

class TiempoTardaMedTradicionalRepositoryDBImpl
    implements TiempoTardaMedTradicionalRepositoryDB {
  final TiempoTardaMedTradicionalLocalDataSource
      tiempoTardaMedTradicionalLocalDataSource;

  TiempoTardaMedTradicionalRepositoryDBImpl(
      {required this.tiempoTardaMedTradicionalLocalDataSource});

  @override
  Future<Either<Failure, List<TiempoTardaMedTradicionalEntity>>>
      getTiemposTardaMedTradicionalRepositoryDB() async {
    try {
      final result = await tiempoTardaMedTradicionalLocalDataSource
          .getTiemposTardaMedTradicional();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiempoTardaMedTradicionalRepositoryDB(
      TiempoTardaMedTradicionalEntity tiempoTardaMedTradicional) async {
    try {
      final result = await tiempoTardaMedTradicionalLocalDataSource
          .saveTiempoTardaMedTradicional(tiempoTardaMedTradicional);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
