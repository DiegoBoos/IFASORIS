import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/nombre_enfermedad_entity.dart';
import '../../../domain/repositories/nombre_enfermedad/nombre_enfermedad_repository.dart';
import '../../datasources/remote/nombre_enfermedad_remote_ds.dart';

class NombreEnfermedadRepositoryImpl implements NombreEnfermedadRepository {
  final NombreEnfermedadRemoteDataSource nombreEnfermedadRemoteDataSource;

  NombreEnfermedadRepositoryImpl(
      {required this.nombreEnfermedadRemoteDataSource});

  @override
  Future<Either<Failure, List<NombreEnfermedadEntity>>>
      getNombresEnfermedadesRepository() async {
    try {
      final result =
          await nombreEnfermedadRemoteDataSource.getNombresEnfermedades();

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
