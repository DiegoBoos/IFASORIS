import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/enfermedad_tratamiento/enfermedad_tratamiento_repository.dart';
import '../../datasources/remote/enfermedad_tratamiento_remote_ds.dart';
import '../../models/enfermedad_tratamiento.dart';

class EnfermedadTratamientoRepositoryImpl
    implements EnfermedadTratamientoRepository {
  final EnfermedadTratamientoRemoteDataSource
      enfermedadTratamientoRemoteDataSource;

  EnfermedadTratamientoRepositoryImpl(
      {required this.enfermedadTratamientoRemoteDataSource});

  @override
  Future<Either<Failure, List<EnfermedadTratamientoModel>>>
      getEnfermedadesTratamientoRepository() async {
    try {
      final result = await enfermedadTratamientoRemoteDataSource
          .getEnfermedadesTratamiento();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
