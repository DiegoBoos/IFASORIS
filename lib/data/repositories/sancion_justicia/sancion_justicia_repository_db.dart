import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/sancion_justicia.dart';
import '../../../domain/repositories/sancion_justicia/sancion_justicia_repository_db.dart';
import '../../datasources/local/sancion_justicia_local_ds.dart';
import '../../models/sancion_justicia.dart';

class SancionJusticiaRepositoryDBImpl implements SancionJusticiaRepositoryDB {
  final SancionJusticiaLocalDataSource sancionJusticiaLocalDataSource;

  SancionJusticiaRepositoryDBImpl(
      {required this.sancionJusticiaLocalDataSource});

  @override
  Future<Either<Failure, List<SancionJusticiaModel>>>
      getSancionesJusticiaRepositoryDB() async {
    try {
      final result =
          await sancionJusticiaLocalDataSource.getSancionesJusticia();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveSancionJusticiaRepositoryDB(
      SancionJusticiaEntity sancionJusticia) async {
    try {
      final sancionJusticiaModel =
          SancionJusticiaModel.fromEntity(sancionJusticia);
      final result = await sancionJusticiaLocalDataSource
          .saveSancionJusticia(sancionJusticiaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
