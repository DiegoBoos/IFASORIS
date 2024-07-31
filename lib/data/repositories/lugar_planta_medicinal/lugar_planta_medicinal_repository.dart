import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/lugar_planta_medicinal/lugar_planta_medicinal_repository.dart';
import '../../datasources/remote/lugar_planta_medicinal_remote_ds.dart';
import '../../models/lugar_planta_medicinal.dart';

class LugarPlantaMedicinalRepositoryImpl
    implements LugarPlantaMedicinalRepository {
  final LugarPlantaMedicinalRemoteDataSource
      lugarPlantaMedicinalRemoteDataSource;

  LugarPlantaMedicinalRepositoryImpl(
      {required this.lugarPlantaMedicinalRemoteDataSource});

  @override
  Future<Either<Failure, List<LugarPlantaMedicinalModel>>>
      getLugaresPlantasMedicinalesRepository(int dtoId) async {
    try {
      final result = await lugarPlantaMedicinalRemoteDataSource
          .getLugaresPlantasMedicinales(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
