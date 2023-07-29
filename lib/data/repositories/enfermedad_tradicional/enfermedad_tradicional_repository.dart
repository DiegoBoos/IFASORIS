import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/enfermedad_tradicional_entity.dart';
import '../../../domain/repositories/enfermedad_tradicional/enfermedad_tradicional_repository.dart';
import '../../datasources/remote/enfermedad_tradicional_remote_ds.dart';

class EnfermedadTradicionalRepositoryImpl
    implements EnfermedadTradicionalRepository {
  final EnfermedadTradicionalRemoteDataSource
      enfermedadTradicionalRemoteDataSource;

  EnfermedadTradicionalRepositoryImpl(
      {required this.enfermedadTradicionalRemoteDataSource});

  @override
  Future<Either<Failure, List<EnfermedadTradicionalEntity>>>
      getEnfermedadesTradicionalesRepository() async {
    try {
      final result = await enfermedadTradicionalRemoteDataSource
          .getEnfermedadesTradicionales();

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
