import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/curso_vida.dart';
import '../../../domain/repositories/curso_vida/curso_vida_repository_db.dart';
import '../../datasources/local/curso_vida_local_ds.dart';
import '../../models/curso_vida.dart';

class CursoVidaRepositoryDBImpl implements CursoVidaRepositoryDB {
  final CursoVidaLocalDataSource cursoVidaLocalDataSource;

  CursoVidaRepositoryDBImpl({required this.cursoVidaLocalDataSource});

  @override
  Future<Either<Failure, List<CursoVidaModel>>>
      getCursosVidaRepositoryDB() async {
    try {
      final result = await cursoVidaLocalDataSource.getCursosVida();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveCursoVidaRepositoryDB(
      CursoVidaEntity cursoVida) async {
    try {
      final cursoVidaModel = CursoVidaModel.fromEntity(cursoVida);
      final result =
          await cursoVidaLocalDataSource.saveCursoVida(cursoVidaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
