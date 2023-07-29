import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/lugar_atencion_medico_entity.dart';
import '../../../domain/repositories/lugar_atencion_medico/lugar_atencion_medico_repository_db.dart';
import '../../datasources/local/lugar_atencion_medico_local_ds.dart';
import '../../models/lugar_atencion_medico_model.dart';

class LugarAtencionMedicoRepositoryDBImpl
    implements LugarAtencionMedicoRepositoryDB {
  final LugarAtencionMedicoLocalDataSource lugarAtencionMedicoLocalDataSource;

  LugarAtencionMedicoRepositoryDBImpl(
      {required this.lugarAtencionMedicoLocalDataSource});

  @override
  Future<Either<Failure, List<LugarAtencionMedicoEntity>>>
      getLugaresAtencionMedicoRepositoryDB() async {
    try {
      final result =
          await lugarAtencionMedicoLocalDataSource.getLugaresAtencionMedico();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveLugarAtencionMedicoRepositoryDB(
      LugarAtencionMedicoEntity lugarAtencionMedico) async {
    try {
      final result = await lugarAtencionMedicoLocalDataSource
          .saveLugarAtencionMedico(lugarAtencionMedico);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
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
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
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
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
