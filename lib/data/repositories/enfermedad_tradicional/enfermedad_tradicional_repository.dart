import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/enfermedad_tradicional/enfermedad_tradicional_repository.dart';
import '../../datasources/remote/enfermedad_tradicional_remote_ds.dart';
import '../../models/enfermedad_tradicional.dart';

class EnfermedadTradicionalRepositoryImpl
    implements EnfermedadTradicionalRepository {
  final EnfermedadTradicionalRemoteDataSource
      enfermedadTradicionalRemoteDataSource;

  EnfermedadTradicionalRepositoryImpl(
      {required this.enfermedadTradicionalRemoteDataSource});

  @override
  Future<Either<Failure, List<EnfermedadTradicionalModel>>>
      getEnfermedadesTradicionalesRepository(int dtoId) async {
    try {
      final result = await enfermedadTradicionalRemoteDataSource
          .getEnfermedadesTradicionales(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
