import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/sancion_justicia_entity.dart';
import '../../../domain/repositories/sancion_justicia/sancion_justicia_repository_db.dart';
import '../../datasources/local/sancion_justicia_local_ds.dart';

class SancionJusticiaRepositoryDBImpl implements SancionJusticiaRepositoryDB {
  final SancionJusticiaLocalDataSource sancionJusticiaLocalDataSource;

  SancionJusticiaRepositoryDBImpl(
      {required this.sancionJusticiaLocalDataSource});

  @override
  Future<Either<Failure, List<SancionJusticiaEntity>>>
      getSancionesJusticiaRepositoryDB() async {
    try {
      final result =
          await sancionJusticiaLocalDataSource.getSancionesJusticia();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveSancionJusticiaRepositoryDB(
      SancionJusticiaEntity sancionJusticia) async {
    try {
      final result = await sancionJusticiaLocalDataSource
          .saveSancionJusticia(sancionJusticia);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
