import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/especialidad_med_tradicional_by_dpto_entity.dart';
import '../../../domain/repositories/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_repository_db.dart';
import '../../datasources/local/especialidad_med_tradicional_by_dpto_local_ds.dart';

class EspecialidadMedTradicionalByDptoRepositoryDBImpl
    implements EspecialidadMedTradicionalByDptoRepositoryDB {
  final EspecialidadMedTradicionalByDptoLocalDataSource
      especialidadMedTradicionalByDptoLocalDataSource;

  EspecialidadMedTradicionalByDptoRepositoryDBImpl(
      {required this.especialidadMedTradicionalByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<EspecialidadMedTradicionalByDptoEntity>>>
      getEspecialidadesMedTradicionalByDptoRepositoryDB(int dtoId) async {
    try {
      final result = await especialidadMedTradicionalByDptoLocalDataSource
          .getEspecialidadesMedTradicionalByDpto(dtoId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEspecialidadMedTradicionalByDptoRepositoryDB(
      EspecialidadMedTradicionalByDptoEntity
          especialidadMedTradicionalByDpto) async {
    try {
      final result = await especialidadMedTradicionalByDptoLocalDataSource
          .saveEspecialidadMedTradicionalByDpto(
              especialidadMedTradicionalByDpto);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
