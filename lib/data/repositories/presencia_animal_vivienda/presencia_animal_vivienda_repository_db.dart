import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/presencia_animal_vivienda_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/presencia_animal_vivienda_entity.dart';
import '../../../domain/repositories/presencia_animal_vivienda/presencia_animal_vivienda_repository_db.dart';
import '../../datasources/local/presencia_animal_vivienda_local_ds.dart';

class PresenciaAnimalViviendaRepositoryDBImpl
    implements PresenciaAnimalViviendaRepositoryDB {
  final PresenciaAnimalViviendaLocalDataSource
      presenciaAnimalViviendaLocalDataSource;

  PresenciaAnimalViviendaRepositoryDBImpl(
      {required this.presenciaAnimalViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<PresenciaAnimalViviendaEntity>>>
      getPresenciaAnimalesRepositoryDB() async {
    try {
      final result =
          await presenciaAnimalViviendaLocalDataSource.getPresenciaAnimales();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePresenciaAnimalViviendaRepositoryDB(
      PresenciaAnimalViviendaEntity presenciaAnimalVivienda) async {
    try {
      final result = await presenciaAnimalViviendaLocalDataSource
          .savePresenciaAnimalVivienda(presenciaAnimalVivienda);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePresenciaAnimalesViviendaRepositoryDB(
      int datoViviendaId, List<LstPresenciaAnimal> lstPresenciaAnimal) async {
    try {
      final result = await presenciaAnimalViviendaLocalDataSource
          .savePresenciaAnimalesVivienda(datoViviendaId, lstPresenciaAnimal);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstPresenciaAnimal>>>
      getPresenciaAnimalesViviendaRepositoryDB(int? datoViviendaId) async {
    try {
      final result = await presenciaAnimalViviendaLocalDataSource
          .getPresenciasAnimalesVivienda(datoViviendaId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
