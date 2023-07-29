import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/seguimiento_enfermedad_entity.dart';
import '../../../domain/repositories/seguimiento_enfermedad/seguimiento_enfermedad_repository.dart';
import '../../datasources/remote/seguimiento_enfermedad_remote_ds.dart';

class SeguimientoEnfermedadRepositoryImpl
    implements SeguimientoEnfermedadRepository {
  final SeguimientoEnfermedadRemoteDataSource
      seguimientoEnfermedadRemoteDataSource;

  SeguimientoEnfermedadRepositoryImpl(
      {required this.seguimientoEnfermedadRemoteDataSource});

  @override
  Future<Either<Failure, List<SeguimientoEnfermedadEntity>>>
      getSeguimientoEnfermedadesRepository() async {
    try {
      final result = await seguimientoEnfermedadRemoteDataSource
          .getSeguimientoEnfermedades();

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
