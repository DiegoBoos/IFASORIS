import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/nombre_enfermedad_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/nombre_enfermedad_entity.dart';
import '../../../domain/repositories/nombre_enfermedad/nombre_enfermedad_repository_db.dart';
import '../../datasources/local/nombre_enfermedad_local_ds.dart';

class NombreEnfermedadRepositoryDBImpl implements NombreEnfermedadRepositoryDB {
  final NombreEnfermedadLocalDataSource nombreEnfermedadLocalDataSource;

  NombreEnfermedadRepositoryDBImpl(
      {required this.nombreEnfermedadLocalDataSource});

  @override
  Future<Either<Failure, List<NombreEnfermedadEntity>>>
      getNombresEnfermedadesRepositoryDB() async {
    try {
      final result =
          await nombreEnfermedadLocalDataSource.getNombresEnfermedades();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveNombreEnfermedadRepositoryDB(
      NombreEnfermedadEntity nombreEnfermedad) async {
    try {
      final result = await nombreEnfermedadLocalDataSource
          .saveNombreEnfermedad(nombreEnfermedad);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
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
    } on ServerException {
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
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
