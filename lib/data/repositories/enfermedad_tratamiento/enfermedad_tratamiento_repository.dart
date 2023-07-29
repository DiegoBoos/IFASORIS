import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/enfermedad_tratamiento_entity.dart';
import '../../../domain/repositories/enfermedad_tratamiento/enfermedad_tratamiento_repository.dart';
import '../../datasources/remote/enfermedad_tratamiento_remote_ds.dart';

class EnfermedadTratamientoRepositoryImpl
    implements EnfermedadTratamientoRepository {
  final EnfermedadTratamientoRemoteDataSource
      enfermedadTratamientoRemoteDataSource;

  EnfermedadTratamientoRepositoryImpl(
      {required this.enfermedadTratamientoRemoteDataSource});

  @override
  Future<Either<Failure, List<EnfermedadTratamientoEntity>>>
      getEnfermedadesTratamientoRepository() async {
    try {
      final result = await enfermedadTratamientoRemoteDataSource
          .getEnfermedadesTratamiento();

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
