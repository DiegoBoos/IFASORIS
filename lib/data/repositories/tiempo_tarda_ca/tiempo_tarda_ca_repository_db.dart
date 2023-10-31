import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tiempo_tarda_ca_entity.dart';
import '../../../domain/repositories/tiempo_tarda_ca/tiempo_tarda_ca_repository_db.dart';
import '../../datasources/local/tiempo_tarda_ca_local_ds.dart';

class TiempoTardaCARepositoryDBImpl implements TiempoTardaCARepositoryDB {
  final TiempoTardaCALocalDataSource tiempoTardaCALocalDataSource;

  TiempoTardaCARepositoryDBImpl({required this.tiempoTardaCALocalDataSource});

  @override
  Future<Either<Failure, List<TiempoTardaCAEntity>>>
      getTiemposTardaCARepositoryDB() async {
    try {
      final result = await tiempoTardaCALocalDataSource.getTiemposTardaCA();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiempoTardaCARepositoryDB(
      TiempoTardaCAEntity tiempoTardaCA) async {
    try {
      final result =
          await tiempoTardaCALocalDataSource.saveTiempoTardaCA(tiempoTardaCA);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
