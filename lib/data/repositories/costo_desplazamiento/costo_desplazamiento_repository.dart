import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/costo_desplazamiento_entity.dart';
import '../../../domain/repositories/costo_desplazamiento/costo_desplazamiento_repository.dart';
import '../../datasources/remote/costo_desplazamiento_remote_ds.dart';

class CostoDesplazamientoRepositoryImpl
    implements CostoDesplazamientoRepository {
  final CostoDesplazamientoRemoteDataSource costoDesplazamientoRemoteDataSource;

  CostoDesplazamientoRepositoryImpl(
      {required this.costoDesplazamientoRemoteDataSource});

  @override
  Future<Either<Failure, List<CostoDesplazamientoEntity>>>
      getCostosDesplazamientoRepository() async {
    try {
      final result =
          await costoDesplazamientoRemoteDataSource.getCostosDesplazamiento();

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
