import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/ocupacion_entity.dart';
import '../../../domain/repositories/ocupacion/ocupacion_repository.dart';
import '../../datasources/remote/ocupacion_remote_ds.dart';

class OcupacionRepositoryImpl implements OcupacionRepository {
  final OcupacionRemoteDataSource ocupacionRemoteDataSource;

  OcupacionRepositoryImpl({required this.ocupacionRemoteDataSource});

  @override
  Future<Either<Failure, List<OcupacionEntity>>>
      getOcupacionesRepository() async {
    try {
      final result = await ocupacionRemoteDataSource.getOcupaciones();

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
