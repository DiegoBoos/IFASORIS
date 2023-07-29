import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/nombre_med_tradicional_model.dart';
import 'package:ifasoris/data/models/especialidad_med_tradicional_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/especialidad_med_tradicional_entity.dart';
import '../../../domain/repositories/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_repository_db.dart';
import '../../datasources/local/especialidad_med_tradicional_by_dpto_local_ds.dart';

class EspecialidadMedTradicionalRepositoryDBImpl
    implements EspecialidadMedTradicionalRepositoryDB {
  final EspecialidadMedTradicionalLocalDataSource
      especialidadMedTradicionalLocalDataSource;

  EspecialidadMedTradicionalRepositoryDBImpl(
      {required this.especialidadMedTradicionalLocalDataSource});

  @override
  Future<Either<Failure, List<EspecialidadMedTradicionalEntity>>>
      getEspecialidadesMedTradicionalRepositoryDB() async {
    try {
      final result = await especialidadMedTradicionalLocalDataSource
          .getEspecialidadesMedTradicional();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEspecialidadMedTradicionalRepositoryDB(
      EspecialidadMedTradicionalEntity especialidadMedTradicional) async {
    try {
      final result = await especialidadMedTradicionalLocalDataSource
          .saveEspecialidadMedTradicional(especialidadMedTradicional);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      saveUbicacionEspecialidadMedTradicionalRepositoryDB(int ubicacionId,
          List<LstEspMedTradicional> lstEspMedTradicional) async {
    try {
      final result = await especialidadMedTradicionalLocalDataSource
          .saveUbicacionEspecialidadMedTradicional(
              ubicacionId, lstEspMedTradicional);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionNombresMedTradicionalRepositoryDB(
      int ubicacionId,
      List<LstNombreMedTradicional> lstNombreMedTradicional) async {
    try {
      final result = await especialidadMedTradicionalLocalDataSource
          .saveUbicacionNombresMedTradicional(
              ubicacionId, lstNombreMedTradicional);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstNombreMedTradicional>>>
      getUbicacionNombresMedTradicionalRepositoryDB(int? ubicacionId) async {
    try {
      final result = await especialidadMedTradicionalLocalDataSource
          .getUbicacionNombresMedTradicional(ubicacionId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstEspMedTradicional>>>
      getUbicacionEspecialidadesMedTradicionalRepositoryDB(
          int? ubicacionId) async {
    try {
      final result = await especialidadMedTradicionalLocalDataSource
          .getUbicacionEspecialidadesMedTradicional(ubicacionId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstEspMedTradicional>>>
      getEspecialidadesMedTradicionalAtencionSaludRepositoryDB(
          int? atencionSaludId) async {
    try {
      final result = await especialidadMedTradicionalLocalDataSource
          .getEspecialidadesMedTradicionalAtencionSalud(atencionSaludId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      saveEspecialidadesMedTradicionalAtencionSaludRepositoryDB(
          int atencionSaludId,
          List<LstEspMedTradicional> lstEspMedTradicional) async {
    try {
      final result = await especialidadMedTradicionalLocalDataSource
          .saveEspecialidadesMedTradicionalAtencionSalud(
              atencionSaludId, lstEspMedTradicional);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
