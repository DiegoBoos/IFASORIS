import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/lugar_vacunacion_entity.dart';
import '../../../domain/repositories/lugar_vacunacion/lugar_vacunacion_repository.dart';
import '../../datasources/remote/lugar_vacunacion_remote_ds.dart';

class LugarVacunacionRepositoryImpl implements LugarVacunacionRepository {
  final LugarVacunacionRemoteDataSource lugarVacunacionRemoteDataSource;

  LugarVacunacionRepositoryImpl(
      {required this.lugarVacunacionRemoteDataSource});

  @override
  Future<Either<Failure, List<LugarVacunacionEntity>>>
      getLugaresVacunacionRepository() async {
    try {
      final result =
          await lugarVacunacionRemoteDataSource.getLugaresVacunacion();

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
