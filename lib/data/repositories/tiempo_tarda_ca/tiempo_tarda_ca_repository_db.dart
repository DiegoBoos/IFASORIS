import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tiempo_tarda_ca.dart';
import '../../../domain/repositories/tiempo_tarda_ca/tiempo_tarda_ca_repository_db.dart';
import '../../datasources/local/tiempo_tarda_ca_local_ds.dart';
import '../../models/tiempo_tarda_ca.dart';

class TiempoTardaCARepositoryDBImpl implements TiempoTardaCARepositoryDB {
  final TiempoTardaCALocalDataSource tiempoTardaCALocalDataSource;

  TiempoTardaCARepositoryDBImpl({required this.tiempoTardaCALocalDataSource});

  @override
  Future<Either<Failure, List<TiempoTardaCAModel>>>
      getTiemposTardaCARepositoryDB() async {
    try {
      final result = await tiempoTardaCALocalDataSource.getTiemposTardaCA();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiempoTardaCARepositoryDB(
      TiempoTardaCAEntity tiempoTardaCA) async {
    try {
      final tiempoTardaCAModel = TiempoTardaCAModel.fromEntity(tiempoTardaCA);
      final result = await tiempoTardaCALocalDataSource
          .saveTiempoTardaCA(tiempoTardaCAModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
