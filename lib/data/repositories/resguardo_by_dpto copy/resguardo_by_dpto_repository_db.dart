import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/resguardo_by_dpto_entity.dart';
import '../../../domain/repositories/resguardo_by_dpto/resguardo_by_dpto_repository_db.dart';
import '../../datasources/local/resguardo_by_dpto_local_ds.dart';

class ResguardoByDptoRepositoryDBImpl implements ResguardoByDptoRepositoryDB {
  final ResguardoByDptoLocalDataSource resguardoByDptoLocalDataSource;

  ResguardoByDptoRepositoryDBImpl(
      {required this.resguardoByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<ResguardoByDptoEntity>>>
      getResguardosByDptoRepositoryDB(int dtoId) async {
    try {
      final resguardoByDptoDB =
          await resguardoByDptoLocalDataSource.getResguardosByDpto(dtoId);
      return Right(resguardoByDptoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveResguardoByDptoRepositoryDB(
      ResguardoByDptoEntity resguardoByDpto) async {
    try {
      final resguardoByDptoDB = await resguardoByDptoLocalDataSource
          .saveResguardoByDpto(resguardoByDpto);
      return Right(resguardoByDptoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
