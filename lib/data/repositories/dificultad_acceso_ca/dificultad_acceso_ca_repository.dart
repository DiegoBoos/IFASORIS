import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dificultad_acceso_ca_entity.dart';
import '../../../domain/repositories/dificultad_acceso_ca/dificultad_acceso_ca_repository.dart';
import '../../datasources/remote/dificultad_acceso_ca_remote_ds.dart';

class DificultadAccesoCARepositoryImpl implements DificultadAccesoCARepository {
  final DificultadAccesoCARemoteDataSource dificultadAccesoCARemoteDataSource;

  DificultadAccesoCARepositoryImpl(
      {required this.dificultadAccesoCARemoteDataSource});

  @override
  Future<Either<Failure, List<DificultadAccesoCAEntity>>>
      getDificultadesAccesoCARepository() async {
    try {
      final result =
          await dificultadAccesoCARemoteDataSource.getDificultadesAccesoCA();

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
