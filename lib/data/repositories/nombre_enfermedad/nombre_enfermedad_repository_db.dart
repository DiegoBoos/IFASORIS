import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/nombre_enfermedad.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/nombre_enfermedad.dart';
import '../../../domain/repositories/nombre_enfermedad/nombre_enfermedad_repository_db.dart';
import '../../datasources/local/nombre_enfermedad_local_ds.dart';

class NombreEnfermedadRepositoryDBImpl implements NombreEnfermedadRepositoryDB {
  final NombreEnfermedadLocalDataSource nombreEnfermedadLocalDataSource;

  NombreEnfermedadRepositoryDBImpl(
      {required this.nombreEnfermedadLocalDataSource});

  @override
  Future<Either<Failure, List<NombreEnfermedadModel>>>
      getNombresEnfermedadesRepositoryDB() async {
    try {
      final result =
          await nombreEnfermedadLocalDataSource.getNombresEnfermedades();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveNombreEnfermedadRepositoryDB(
      NombreEnfermedadEntity nombreEnfermedad) async {
    try {
      final nombreEnfermedadModel =
          NombreEnfermedadModel.fromEntity(nombreEnfermedad);
      final result = await nombreEnfermedadLocalDataSource
          .saveNombreEnfermedad(nombreEnfermedadModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstNombreEnfermedad>>>
      getLstNombresEnfermedadesRepositoryDB(
          int? cuidadoSaludCondRiesgoId) async {
    try {
      final result = await nombreEnfermedadLocalDataSource
          .getLstNombresEnfermedades(cuidadoSaludCondRiesgoId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveNombresEnfermedadesRepositoryDB(
      int cuidadoSaludCondRiesgoId,
      List<LstNombreEnfermedad> lstNombresEnfermedades) async {
    try {
      final result =
          await nombreEnfermedadLocalDataSource.saveNombresEnfermedades(
              cuidadoSaludCondRiesgoId, lstNombresEnfermedades);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
