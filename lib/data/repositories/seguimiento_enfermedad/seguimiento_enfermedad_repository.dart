import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/seguimiento_enfermedad/seguimiento_enfermedad_repository.dart';
import '../../datasources/remote/seguimiento_enfermedad_remote_ds.dart';
import '../../models/seguimiento_enfermedad.dart';

class SeguimientoEnfermedadRepositoryImpl
    implements SeguimientoEnfermedadRepository {
  final SeguimientoEnfermedadRemoteDataSource
      seguimientoEnfermedadRemoteDataSource;

  SeguimientoEnfermedadRepositoryImpl(
      {required this.seguimientoEnfermedadRemoteDataSource});

  @override
  Future<Either<Failure, List<SeguimientoEnfermedadModel>>>
      getSeguimientoEnfermedadesRepository() async {
    try {
      final result = await seguimientoEnfermedadRemoteDataSource
          .getSeguimientoEnfermedades();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
