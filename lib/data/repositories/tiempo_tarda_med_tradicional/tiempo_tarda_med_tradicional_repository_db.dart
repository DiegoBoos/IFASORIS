import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/tiempo_tarda_med_tradicional.dart';
import '../../../domain/repositories/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_repository_db.dart';
import '../../datasources/local/tiempo_tarda_med_tradicional_local_ds.dart';
import '../../models/tiempo_tarda_med_tradicional.dart';

class TiempoTardaMedTradicionalRepositoryDBImpl
    implements TiempoTardaMedTradicionalRepositoryDB {
  final TiempoTardaMedTradicionalLocalDataSource
      tiempoTardaMedTradicionalLocalDataSource;

  TiempoTardaMedTradicionalRepositoryDBImpl(
      {required this.tiempoTardaMedTradicionalLocalDataSource});

  @override
  Future<Either<Failure, List<TiempoTardaMedTradicionalModel>>>
      getTiemposTardaMedTradicionalRepositoryDB() async {
    try {
      final result = await tiempoTardaMedTradicionalLocalDataSource
          .getTiemposTardaMedTradicional();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiempoTardaMedTradicionalRepositoryDB(
      TiempoTardaMedTradicionalEntity tiempoTardaMedTradicional) async {
    try {
      final tiempoTardaMedTradicionalModel =
          TiempoTardaMedTradicionalModel.fromEntity(tiempoTardaMedTradicional);
      final result = await tiempoTardaMedTradicionalLocalDataSource
          .saveTiempoTardaMedTradicional(tiempoTardaMedTradicionalModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
