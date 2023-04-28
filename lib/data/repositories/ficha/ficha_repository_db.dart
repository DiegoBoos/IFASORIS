import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/ficha_entity.dart';
import '../../../domain/repositories/ficha/ficha_repository_db.dart';
import '../../datasources/local/ficha_local_ds.dart';

class FichaRepositoryDBImpl implements FichaRepositoryDB {
  final FichaLocalDataSource fichaLocalDataSource;

  FichaRepositoryDBImpl({required this.fichaLocalDataSource});

  @override
  Future<Either<Failure, FichaEntity>> createFichaRepositoryDB(
      FichaEntity ficha) async {
    try {
      final result = await fichaLocalDataSource.createFicha(ficha);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<FichaEntity>>> loadFichasRepositoryDB() async {
    try {
      final result = await fichaLocalDataSource.loadFichas();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
