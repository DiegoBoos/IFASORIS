import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/techo_vivienda_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/techo_vivienda_entity.dart';
import '../../../domain/repositories/techo_vivienda/techo_vivienda_repository_db.dart';
import '../../datasources/local/techo_vivienda_local_ds.dart';

class TechoViviendaRepositoryDBImpl implements TechoViviendaRepositoryDB {
  final TechoViviendaLocalDataSource techoViviendaLocalDataSource;

  TechoViviendaRepositoryDBImpl({required this.techoViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<TechoViviendaEntity>>>
      getTechosViviendaRepositoryDB() async {
    try {
      final result = await techoViviendaLocalDataSource.getTechosVivienda();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTechoViviendaRepositoryDB(
      TechoViviendaEntity techoVivienda) async {
    try {
      final result =
          await techoViviendaLocalDataSource.saveTechoVivienda(techoVivienda);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTechosViviendaRepositoryDB(
      int datoViviendaId, List<LstTecho> lstTecho) async {
    try {
      final result = await techoViviendaLocalDataSource.saveTechosVivienda(
          datoViviendaId, lstTecho);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstTecho>>> getTechosViviendaViviendaRepositoryDB(
      int? datoViviendaId) async {
    try {
      final result = await techoViviendaLocalDataSource
          .getTechosViviendaVivienda(datoViviendaId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
