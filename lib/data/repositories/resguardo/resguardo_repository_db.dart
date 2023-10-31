import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/resguardo_entity.dart';
import '../../../domain/repositories/resguardo/resguardo_repository_db.dart';
import '../../datasources/local/resguardo_local_ds.dart';

class ResguardoRepositoryDBImpl implements ResguardoRepositoryDB {
  final ResguardoLocalDataSource resguardoLocalDataSource;

  ResguardoRepositoryDBImpl({required this.resguardoLocalDataSource});

  @override
  Future<Either<Failure, List<ResguardoEntity>>>
      getResguardosRepositoryDB() async {
    try {
      final result = await resguardoLocalDataSource.getResguardos();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveResguardoRepositoryDB(
      ResguardoEntity resguardo) async {
    try {
      final result = await resguardoLocalDataSource.saveResguardo(resguardo);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
