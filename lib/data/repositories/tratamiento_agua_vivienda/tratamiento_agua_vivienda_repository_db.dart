import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tratamiento_agua_vivienda_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tratamiento_agua_vivienda_entity.dart';
import '../../../domain/repositories/tratamiento_agua_vivienda/tratamiento_agua_vivienda_repository_db.dart';
import '../../datasources/local/tratamiento_agua_vivienda_local_ds.dart';

class TratamientoAguaViviendaRepositoryDBImpl
    implements TratamientoAguaViviendaRepositoryDB {
  final TratamientoAguaViviendaLocalDataSource
      tratamientoAguaViviendaLocalDataSource;

  TratamientoAguaViviendaRepositoryDBImpl(
      {required this.tratamientoAguaViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<TratamientoAguaViviendaEntity>>>
      getTratamientosAguaRepositoryDB() async {
    try {
      final result =
          await tratamientoAguaViviendaLocalDataSource.getTratamientosAgua();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTratamientoAguaViviendaRepositoryDB(
      TratamientoAguaViviendaEntity tratamientoAguaVivienda) async {
    try {
      final result = await tratamientoAguaViviendaLocalDataSource
          .saveTratamientoAguaVivienda(tratamientoAguaVivienda);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTmtoAguasViviendaRepositoryDB(
      int datoViviendaId, List<LstTmtoAgua> lstTmtoAgua) async {
    try {
      final result = await tratamientoAguaViviendaLocalDataSource
          .saveTmtoAguasVivienda(datoViviendaId, lstTmtoAgua);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstTmtoAgua>>>
      getTratamientosAguaViviendaRepositoryDB(int? datoViviendaId) async {
    try {
      final result = await tratamientoAguaViviendaLocalDataSource
          .getTratamientosAguaVivienda(datoViviendaId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
