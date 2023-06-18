import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/curso_vida_entity.dart';
import '../../../domain/repositories/curso_vida/curso_vida_repository.dart';
import '../../datasources/remote/curso_vida_remote_ds.dart';

class CursoVidaRepositoryImpl implements CursoVidaRepository {
  final CursoVidaRemoteDataSource cursoVidaRemoteDataSource;

  CursoVidaRepositoryImpl({required this.cursoVidaRemoteDataSource});

  @override
  Future<Either<Failure, List<CursoVidaEntity>>>
      getCursosVidaRepository() async {
    try {
      final result = await cursoVidaRemoteDataSource.getCursosVida();

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
