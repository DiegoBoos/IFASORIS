import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/nombre_med_tradicional.dart';
import 'package:ifasoris/data/models/especialidad_med_tradicional.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/especialidad_med_tradicional.dart';
import '../../../domain/repositories/especialidad_med_tradicional/especialidad_med_tradicional_repository_db.dart';
import '../../datasources/local/especialidad_med_tradicional_local_ds.dart';

class EspecialidadMedTradicionalRepositoryDBImpl
    implements EspecialidadMedTradicionalRepositoryDB {
  final EspecialidadMedTradicionalLocalDataSource
      especialidadMedTradicionalLocalDataSource;

  EspecialidadMedTradicionalRepositoryDBImpl(
      {required this.especialidadMedTradicionalLocalDataSource});

  @override
  Future<Either<Failure, List<EspecialidadMedTradicionalModel>>>
      getEspecialidadesMedTradicionalRepositoryDB() async {
    try {
      final result = await especialidadMedTradicionalLocalDataSource
          .getEspecialidadesMedTradicional();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveEspecialidadMedTradicionalRepositoryDB(
      EspecialidadMedTradicionalEntity especialidadMedTradicional) async {
    try {
      final especialidadMedTradicionalModel =
          EspecialidadMedTradicionalModel.fromEntity(
              especialidadMedTradicional);

      final result = await especialidadMedTradicionalLocalDataSource
          .saveEspecialidadMedTradicional(especialidadMedTradicionalModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
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
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
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
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<LstNombreMedTradicional>>>
      getUbicacionNombresMedTradicionalRepositoryDB(int? ubicacionId) async {
    try {
      final result = await especialidadMedTradicionalLocalDataSource
          .getUbicacionNombresMedTradicional(ubicacionId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
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
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
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
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
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
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
