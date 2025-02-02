import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/ocupacion/ocupacion_repository.dart';
import '../../datasources/remote/ocupacion_remote_ds.dart';
import '../../models/ocupacion.dart';

class OcupacionRepositoryImpl implements OcupacionRepository {
  final OcupacionRemoteDataSource ocupacionRemoteDataSource;

  OcupacionRepositoryImpl({required this.ocupacionRemoteDataSource});

  @override
  Future<Either<Failure, List<OcupacionModel>>>
      getOcupacionesRepository() async {
    try {
      final result = await ocupacionRemoteDataSource.getOcupaciones();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
