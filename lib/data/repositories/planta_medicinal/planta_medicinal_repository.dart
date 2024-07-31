import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/planta_medicinal/planta_medicinal_repository.dart';
import '../../datasources/remote/planta_medicinal_remote_ds.dart';
import '../../models/planta_medicinal.dart';

class PlantaMedicinalRepositoryImpl implements PlantaMedicinalRepository {
  final PlantaMedicinalRemoteDataSource plantaMedicinalRemoteDataSource;

  PlantaMedicinalRepositoryImpl(
      {required this.plantaMedicinalRemoteDataSource});

  @override
  Future<Either<Failure, List<PlantaMedicinalModel>>>
      getPlantasMedicinalesRepository(int dtoId) async {
    try {
      final result =
          await plantaMedicinalRemoteDataSource.getPlantasMedicinales(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
