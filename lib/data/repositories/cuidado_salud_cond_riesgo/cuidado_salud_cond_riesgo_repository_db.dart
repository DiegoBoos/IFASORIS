import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/cuidado_salud_cond_riesgo.dart';
import '../../../domain/repositories/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_repository_db.dart';
import '../../datasources/local/cuidado_salud_cond_riesgo_local_ds.dart';
import '../../models/cuidado_salud_cond_riesgo.dart';

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
      final cuidadoSaludCondRiesgoModel =
          CuidadoSaludCondRiesgoModel.fromEntity(cuidadoSaludCondRiesgo);

      final result = await cuidadoSaludCondRiesgoLocalDataSource
          .saveCuidadoSaludCondRiesgo(cuidadoSaludCondRiesgoModel);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, CuidadoSaludCondRiesgoModel?>>
      getCuidadoSaludCondRiesgoRepositoryDB(int afiliadoId) async {
    try {
      final result = await cuidadoSaludCondRiesgoLocalDataSource
          .getCuidadoSaludCondRiesgo(afiliadoId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
