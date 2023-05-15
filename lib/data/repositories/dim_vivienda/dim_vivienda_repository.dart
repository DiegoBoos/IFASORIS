import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dim_vivienda_entity.dart';
import '../../../domain/repositories/dim_vivienda/dim_vivienda_repository.dart';
import '../../datasources/remote/dim_vivienda_remote_ds.dart';

class DimViviendaRepositoryImpl implements DimViviendaRepository {
  final DimViviendaRemoteDataSource dimViviendaRemoteDataSource;

  DimViviendaRepositoryImpl({required this.dimViviendaRemoteDataSource});

  @override
  Future<Either<Failure, DimViviendaEntity>>
      uploadDimViviendaRepository() async {
    try {
      final result = await dimViviendaRemoteDataSource.uploadDimVivienda();

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
