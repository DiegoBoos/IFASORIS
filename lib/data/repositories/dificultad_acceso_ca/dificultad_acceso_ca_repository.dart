import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/dificultad_acceso_ca/dificultad_acceso_ca_repository.dart';
import '../../datasources/remote/dificultad_acceso_ca_remote_ds.dart';
import '../../models/dificultad_acceso_ca.dart';

class DificultadAccesoCARepositoryImpl implements DificultadAccesoCARepository {
  final DificultadAccesoCARemoteDataSource dificultadAccesoCARemoteDataSource;

  DificultadAccesoCARepositoryImpl(
      {required this.dificultadAccesoCARemoteDataSource});

  @override
  Future<Either<Failure, List<DificultadAccesoCAModel>>>
      getDificultadesAccesoCARepository() async {
    try {
      final result =
          await dificultadAccesoCARemoteDataSource.getDificultadesAccesoCA();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
