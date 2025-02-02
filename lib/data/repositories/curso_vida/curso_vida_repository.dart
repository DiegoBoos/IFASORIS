import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/curso_vida/curso_vida_repository.dart';
import '../../datasources/remote/curso_vida_remote_ds.dart';
import '../../models/curso_vida.dart';

class CursoVidaRepositoryImpl implements CursoVidaRepository {
  final CursoVidaRemoteDataSource cursoVidaRemoteDataSource;

  CursoVidaRepositoryImpl({required this.cursoVidaRemoteDataSource});

  @override
  Future<Either<Failure, List<CursoVidaModel>>>
      getCursosVidaRepository() async {
    try {
      final result = await cursoVidaRemoteDataSource.getCursosVida();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
