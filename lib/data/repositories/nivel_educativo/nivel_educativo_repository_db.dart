import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/nivel_educativo_entity.dart';
import '../../../domain/repositories/nivel_educativo/nivel_educativo_repository_db.dart';
import '../../datasources/local/nivel_educativo_local_ds.dart';

class NivelEducativoRepositoryDBImpl implements NivelEducativoRepositoryDB {
  final NivelEducativoLocalDataSource nivelEducativoLocalDataSource;

  NivelEducativoRepositoryDBImpl({required this.nivelEducativoLocalDataSource});

  @override
  Future<Either<Failure, List<NivelEducativoEntity>>>
      getNivelesEducativosRepositoryDB() async {
    try {
      final result = await nivelEducativoLocalDataSource.getNivelesEducativos();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveNivelEducativoRepositoryDB(
      NivelEducativoEntity nivelEducativo) async {
    try {
      final result = await nivelEducativoLocalDataSource
          .saveNivelEducativo(nivelEducativo);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
