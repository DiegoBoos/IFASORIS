import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/nivel_educativo_entity.dart';
import '../../../domain/repositories/nivel_educativo/nivel_educativo_repository.dart';
import '../../datasources/remote/nivel_educativo_remote_ds.dart';

class NivelEducativoRepositoryImpl implements NivelEducativoRepository {
  final NivelEducativoRemoteDataSource nivelEducativoRemoteDataSource;

  NivelEducativoRepositoryImpl({required this.nivelEducativoRemoteDataSource});

  @override
  Future<Either<Failure, List<NivelEducativoEntity>>>
      getNivelesEducativosRepository() async {
    try {
      final result =
          await nivelEducativoRemoteDataSource.getNivelesEducativos();

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
