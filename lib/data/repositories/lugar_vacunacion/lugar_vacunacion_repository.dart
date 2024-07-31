import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/lugar_vacunacion/lugar_vacunacion_repository.dart';
import '../../datasources/remote/lugar_vacunacion_remote_ds.dart';
import '../../models/lugar_vacunacion.dart';

class LugarVacunacionRepositoryImpl implements LugarVacunacionRepository {
  final LugarVacunacionRemoteDataSource lugarVacunacionRemoteDataSource;

  LugarVacunacionRepositoryImpl(
      {required this.lugarVacunacionRemoteDataSource});

  @override
  Future<Either<Failure, List<LugarVacunacionModel>>>
      getLugaresVacunacionRepository() async {
    try {
      final result =
          await lugarVacunacionRemoteDataSource.getLugaresVacunacion();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
