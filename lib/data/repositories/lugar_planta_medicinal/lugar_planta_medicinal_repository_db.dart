import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/lugar_planta_medicinal_entity.dart';
import '../../../domain/repositories/lugar_planta_medicinal/lugar_planta_medicinal_repository_db.dart';
import '../../datasources/local/lugar_planta_medicinal_local_ds.dart';

class LugarPlantaMedicinalRepositoryDBImpl
    implements LugarPlantaMedicinalRepositoryDB {
  final LugarPlantaMedicinalLocalDataSource lugarPlantaMedicinalLocalDataSource;

  LugarPlantaMedicinalRepositoryDBImpl(
      {required this.lugarPlantaMedicinalLocalDataSource});

  @override
  Future<Either<Failure, List<LugarPlantaMedicinalEntity>>>
      getLugaresPlantasMedicinalesRepositoryDB() async {
    try {
      final result = await lugarPlantaMedicinalLocalDataSource
          .getLugaresPlantasMedicinales();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveLugarPlantaMedicinalRepositoryDB(
      LugarPlantaMedicinalEntity lugarPlantaMedicinal) async {
    try {
      final result = await lugarPlantaMedicinalLocalDataSource
          .saveLugarPlantaMedicinal(lugarPlantaMedicinal);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
