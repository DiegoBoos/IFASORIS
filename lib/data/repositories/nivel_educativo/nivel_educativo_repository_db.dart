import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/nivel_educativo.dart';
import '../../../domain/repositories/nivel_educativo/nivel_educativo_repository_db.dart';
import '../../datasources/local/nivel_educativo_local_ds.dart';
import '../../models/nivel_educativo.dart';

class NivelEducativoRepositoryDBImpl implements NivelEducativoRepositoryDB {
  final NivelEducativoLocalDataSource nivelEducativoLocalDataSource;

  NivelEducativoRepositoryDBImpl({required this.nivelEducativoLocalDataSource});

  @override
  Future<Either<Failure, List<NivelEducativoModel>>>
      getNivelesEducativosRepositoryDB() async {
    try {
      final result = await nivelEducativoLocalDataSource.getNivelesEducativos();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveNivelEducativoRepositoryDB(
      NivelEducativoEntity nivelEducativo) async {
    try {
      final nivelEducativoModel =
          NivelEducativoModel.fromEntity(nivelEducativo);
      final result = await nivelEducativoLocalDataSource
          .saveNivelEducativo(nivelEducativoModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
