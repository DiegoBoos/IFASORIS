import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/grupo_riesgo/grupo_riesgo_repository.dart';
import '../../datasources/remote/grupo_riesgo_remote_ds.dart';
import '../../models/grupo_riesgo.dart';

class GrupoRiesgoRepositoryImpl implements GrupoRiesgoRepository {
  final GrupoRiesgoRemoteDataSource grupoRiesgoRemoteDataSource;

  GrupoRiesgoRepositoryImpl({required this.grupoRiesgoRemoteDataSource});

  @override
  Future<Either<Failure, List<GrupoRiesgoModel>>>
      getGruposRiesgoRepository() async {
    try {
      final result = await grupoRiesgoRemoteDataSource.getGruposRiesgo();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
