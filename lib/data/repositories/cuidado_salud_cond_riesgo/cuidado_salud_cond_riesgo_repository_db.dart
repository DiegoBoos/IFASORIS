import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/cuidado_salud_cond_riesgo_entity.dart';
import '../../../domain/repositories/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_repository_db.dart';
import '../../datasources/local/cuidado_salud_cond_riesgo_local_ds.dart';

class CuidadoSaludCondRiesgoRepositoryDBImpl
    implements CuidadoSaludCondRiesgoRepositoryDB {
  final CuidadoSaludCondRiesgoLocalDataSource
      cuidadoSaludCondRiesgoLocalDataSource;

  CuidadoSaludCondRiesgoRepositoryDBImpl(
      {required this.cuidadoSaludCondRiesgoLocalDataSource});

  @override
  Future<Either<Failure, int>> saveCuidadoSaludCondRiesgoRepositoryDB(
      CuidadoSaludCondRiesgoEntity cuidadoSaludCondRiesgo) async {
    try {
      final result = await cuidadoSaludCondRiesgoLocalDataSource
          .saveCuidadoSaludCondRiesgo(cuidadoSaludCondRiesgo);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, CuidadoSaludCondRiesgoEntity?>>
      getCuidadoSaludCondRiesgoRepositoryDB(int afiliadoId) async {
    try {
      final result = await cuidadoSaludCondRiesgoLocalDataSource
          .getCuidadoSaludCondRiesgo(afiliadoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
