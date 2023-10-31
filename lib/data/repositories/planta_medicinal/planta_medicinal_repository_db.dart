import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/planta_medicinal_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/planta_medicinal_entity.dart';
import '../../../domain/repositories/planta_medicinal/planta_medicinal_repository_db.dart';
import '../../datasources/local/planta_medicinal_local_ds.dart';

class PlantaMedicinalRepositoryDBImpl implements PlantaMedicinalRepositoryDB {
  final PlantaMedicinalLocalDataSource plantaMedicinalLocalDataSource;

  PlantaMedicinalRepositoryDBImpl(
      {required this.plantaMedicinalLocalDataSource});

  @override
  Future<Either<Failure, List<PlantaMedicinalEntity>>>
      getPlantasMedicinalesRepositoryDB() async {
    try {
      final result =
          await plantaMedicinalLocalDataSource.getPlantasMedicinales();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePlantaMedicinalRepositoryDB(
      PlantaMedicinalEntity plantaMedicinal) async {
    try {
      final result = await plantaMedicinalLocalDataSource
          .savePlantaMedicinal(plantaMedicinal);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstPlantaMedicinal>>>
      getPlantasMedicinalesAtencionSaludRepositoryDB(
          int? atencionSaludId) async {
    try {
      final result = await plantaMedicinalLocalDataSource
          .getPlantasMedicinalesAtencionSalud(atencionSaludId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePlantasMedicinalesAtencionSaludRepositoryDB(
      int atencionSaludId, List<LstPlantaMedicinal> lstPlantaMedicinal) async {
    try {
      final result = await plantaMedicinalLocalDataSource
          .savePlantasMedicinalesAtencionSalud(
              atencionSaludId, lstPlantaMedicinal);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
