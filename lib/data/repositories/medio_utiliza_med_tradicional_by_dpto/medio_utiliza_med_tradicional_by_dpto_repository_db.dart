import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/medio_utiliza_med_tradicional_entity.dart';
import '../../../domain/repositories/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_repository_db.dart';
import '../../datasources/local/medio_utiliza_med_tradicional_by_dpto_local_ds.dart';

class MedioUtilizaMedTradicionalByDptoRepositoryDBImpl
    implements MedioUtilizaMedTradicionalByDptoRepositoryDB {
  final MedioUtilizaMedTradicionalByDptoLocalDataSource
      medioUtilizaMedTradicionalByDptoLocalDataSource;

  MedioUtilizaMedTradicionalByDptoRepositoryDBImpl(
      {required this.medioUtilizaMedTradicionalByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<MedioUtilizaMedTradicionalEntity>>>
      getMediosUtilizaMedTradicionalByDptoRepositoryDB() async {
    try {
      final result = await medioUtilizaMedTradicionalByDptoLocalDataSource
          .getMediosUtilizaMedTradicionalByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveMedioUtilizaMedTradicionalByDptoRepositoryDB(
      MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicionalByDpto) async {
    try {
      final result = await medioUtilizaMedTradicionalByDptoLocalDataSource
          .saveMedioUtilizaMedTradicionalByDpto(
              medioUtilizaMedTradicionalByDpto);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
