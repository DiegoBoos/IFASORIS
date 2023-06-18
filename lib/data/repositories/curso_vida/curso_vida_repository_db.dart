import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/curso_vida_entity.dart';
import '../../../domain/repositories/curso_vida/curso_vida_repository_db.dart';
import '../../datasources/local/curso_vida_local_ds.dart';

class CursoVidaRepositoryDBImpl implements CursoVidaRepositoryDB {
  final CursoVidaLocalDataSource cursoVidaLocalDataSource;

  CursoVidaRepositoryDBImpl({required this.cursoVidaLocalDataSource});

  @override
  Future<Either<Failure, List<CursoVidaEntity>>>
      getCursosVidaRepositoryDB() async {
    try {
      final result = await cursoVidaLocalDataSource.getCursosVida();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveCursoVidaRepositoryDB(
      CursoVidaEntity cursoVida) async {
    try {
      final result = await cursoVidaLocalDataSource.saveCursoVida(cursoVida);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
