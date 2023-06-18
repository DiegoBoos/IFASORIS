import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../../domain/repositories/grupo_familiar/grupo_familiar_repository.dart';
import '../../datasources/remote/grupo_familiar_remote_ds.dart';

class GrupoFamiliarRepositoryImpl implements GrupoFamiliarRepository {
  final GrupoFamiliarRemoteDataSource grupoFamiliarRemoteDataSource;

  GrupoFamiliarRepositoryImpl({required this.grupoFamiliarRemoteDataSource});

  @override
  Future<Either<Failure, GrupoFamiliarEntity>>
      uploadGrupoFamiliarRepository() async {
    try {
      final result = await grupoFamiliarRemoteDataSource.uploadGrupoFamiliar();

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
