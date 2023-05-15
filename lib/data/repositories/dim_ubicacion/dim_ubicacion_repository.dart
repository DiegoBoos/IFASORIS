import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/repositories/dim_ubicacion/dim_ubicacion_repository.dart';
import '../../datasources/remote/dim_ubicacion_remote_ds.dart';

class DimUbicacionRepositoryImpl implements DimUbicacionRepository {
  final DimUbicacionRemoteDataSource dimUbicacionRemoteDataSource;

  DimUbicacionRepositoryImpl({required this.dimUbicacionRemoteDataSource});

  @override
  Future<Either<Failure, DimUbicacionEntity>>
      uploadDimUbicacionRepository() async {
    try {
      final result = await dimUbicacionRemoteDataSource.uploadDimUbicacion();

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
