import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/grupo_riesgo_entity.dart';
import '../../../domain/repositories/grupo_riesgo/grupo_riesgo_repository.dart';
import '../../datasources/remote/grupo_riesgo_remote_ds.dart';

class GrupoRiesgoRepositoryImpl implements GrupoRiesgoRepository {
  final GrupoRiesgoRemoteDataSource grupoRiesgoRemoteDataSource;

  GrupoRiesgoRepositoryImpl({required this.grupoRiesgoRemoteDataSource});

  @override
  Future<Either<Failure, List<GrupoRiesgoEntity>>>
      getGruposRiesgoRepository() async {
    try {
      final result = await grupoRiesgoRemoteDataSource.getGruposRiesgo();

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
