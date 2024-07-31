import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/costo_desplazamiento/costo_desplazamiento_repository.dart';
import '../../datasources/remote/costo_desplazamiento_remote_ds.dart';
import '../../models/costo_desplazamiento.dart';

class CostoDesplazamientoRepositoryImpl
    implements CostoDesplazamientoRepository {
  final CostoDesplazamientoRemoteDataSource costoDesplazamientoRemoteDataSource;

  CostoDesplazamientoRepositoryImpl(
      {required this.costoDesplazamientoRemoteDataSource});

  @override
  Future<Either<Failure, List<CostoDesplazamientoModel>>>
      getCostosDesplazamientoRepository() async {
    try {
      final result =
          await costoDesplazamientoRemoteDataSource.getCostosDesplazamiento();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
