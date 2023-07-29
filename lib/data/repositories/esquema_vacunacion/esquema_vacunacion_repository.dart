import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/esquema_vacunacion_entity.dart';
import '../../../domain/repositories/esquema_vacunacion/esquema_vacunacion_repository.dart';
import '../../datasources/remote/esquema_vacunacion_remote_ds.dart';

class EsquemaVacunacionRepositoryImpl implements EsquemaVacunacionRepository {
  final EsquemaVacunacionRemoteDataSource esquemaVacunacionRemoteDataSource;

  EsquemaVacunacionRepositoryImpl(
      {required this.esquemaVacunacionRemoteDataSource});

  @override
  Future<Either<Failure, List<EsquemaVacunacionEntity>>>
      getEsquemasVacunacionRepository() async {
    try {
      final result =
          await esquemaVacunacionRemoteDataSource.getEsquemasVacunacion();

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
