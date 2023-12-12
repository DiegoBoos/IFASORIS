import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/planta_medicinal_entity.dart';
import '../../../domain/repositories/planta_medicinal/planta_medicinal_repository.dart';
import '../../datasources/remote/planta_medicinal_remote_ds.dart';

class PlantaMedicinalRepositoryImpl implements PlantaMedicinalRepository {
  final PlantaMedicinalRemoteDataSource plantaMedicinalRemoteDataSource;

  PlantaMedicinalRepositoryImpl(
      {required this.plantaMedicinalRemoteDataSource});

  @override
  Future<Either<Failure, List<PlantaMedicinalEntity>>>
      getPlantasMedicinalesRepository(int dtoId) async {
    try {
      final result =
          await plantaMedicinalRemoteDataSource.getPlantasMedicinales(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
