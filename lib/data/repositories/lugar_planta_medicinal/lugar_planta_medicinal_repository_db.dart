import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/lugar_planta_medicinal.dart';
import '../../../domain/repositories/lugar_planta_medicinal/lugar_planta_medicinal_repository_db.dart';
import '../../datasources/local/lugar_planta_medicinal_local_ds.dart';
import '../../models/lugar_planta_medicinal.dart';

class LugarPlantaMedicinalRepositoryDBImpl
    implements LugarPlantaMedicinalRepositoryDB {
  final LugarPlantaMedicinalLocalDataSource lugarPlantaMedicinalLocalDataSource;

  LugarPlantaMedicinalRepositoryDBImpl(
      {required this.lugarPlantaMedicinalLocalDataSource});

  @override
  Future<Either<Failure, List<LugarPlantaMedicinalModel>>>
      getLugaresPlantasMedicinalesRepositoryDB() async {
    try {
      final result = await lugarPlantaMedicinalLocalDataSource
          .getLugaresPlantasMedicinales();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveLugarPlantaMedicinalRepositoryDB(
      LugarPlantaMedicinalEntity lugarPlantaMedicinal) async {
    try {
      final lugarPlantaMedicinalModel =
          LugarPlantaMedicinalModel.fromEntity(lugarPlantaMedicinal);
      final result = await lugarPlantaMedicinalLocalDataSource
          .saveLugarPlantaMedicinal(lugarPlantaMedicinalModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
