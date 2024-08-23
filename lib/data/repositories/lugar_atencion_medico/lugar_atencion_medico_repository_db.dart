import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/lugar_atencion_medico.dart';
import '../../../domain/repositories/lugar_atencion_medico/lugar_atencion_medico_repository_db.dart';
import '../../datasources/local/lugar_atencion_medico_local_ds.dart';
import '../../models/lugar_atencion_medico.dart';

class LugarAtencionMedicoRepositoryDBImpl
    implements LugarAtencionMedicoRepositoryDB {
  final LugarAtencionMedicoLocalDataSource lugarAtencionMedicoLocalDataSource;

  LugarAtencionMedicoRepositoryDBImpl(
      {required this.lugarAtencionMedicoLocalDataSource});

  @override
  Future<Either<Failure, List<LugarAtencionMedicoModel>>>
      getLugaresAtencionMedicoRepositoryDB() async {
    try {
      final result =
          await lugarAtencionMedicoLocalDataSource.getLugaresAtencionMedico();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveLugarAtencionMedicoRepositoryDB(
      LugarAtencionMedicoEntity lugarAtencionMedico) async {
    try {
      final lugarAtencionMedicoModel =
          LugarAtencionMedicoModel.fromEntity(lugarAtencionMedico);
      final result = await lugarAtencionMedicoLocalDataSource
          .saveLugarAtencionMedico(lugarAtencionMedicoModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<LstLugarAtencionMedico>>>
      getLugaresAtencionMedicoAtencionSaludRepositoryDB(
          int? atencionSaludId) async {
    try {
      final result = await lugarAtencionMedicoLocalDataSource
          .getLugaresAtencionMedicoAtencionSalud(atencionSaludId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>>
      saveLugaresAtencionMedicoAtencionSaludRepositoryDB(int atencionSaludId,
          List<LstLugarAtencionMedico> lstLugarAtencionMedico) async {
    try {
      final result = await lugarAtencionMedicoLocalDataSource
          .saveLugaresAtencionMedicoAtencionSalud(
              atencionSaludId, lstLugarAtencionMedico);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
