import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/piso_vivienda.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/piso_vivienda.dart';
import '../../../domain/repositories/piso_vivienda/piso_vivienda_repository_db.dart';
import '../../datasources/local/piso_vivienda_local_ds.dart';

class PisoViviendaRepositoryDBImpl implements PisoViviendaRepositoryDB {
  final PisoViviendaLocalDataSource pisoViviendaLocalDataSource;

  PisoViviendaRepositoryDBImpl({required this.pisoViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<PisoViviendaModel>>>
      getPisosViviendaRepositoryDB() async {
    try {
      final result = await pisoViviendaLocalDataSource.getPisosVivienda();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePisoViviendaRepositoryDB(
      PisoViviendaEntity pisoVivienda) async {
    try {
      final pisoViviendaModel = PisoViviendaModel.fromEntity(pisoVivienda);
      final result =
          await pisoViviendaLocalDataSource.savePisoVivienda(pisoViviendaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstPiso>>> getPisosViviendaViviendaRepositoryDB(
      int? datoViviendaId) async {
    try {
      final result = await pisoViviendaLocalDataSource
          .getPisosViviendaVivienda(datoViviendaId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePisosViviendaRepositoryDB(
      int datoViviendaId, List<LstPiso> lstPiso) async {
    try {
      final result = await pisoViviendaLocalDataSource.savePisosVivienda(
          datoViviendaId, lstPiso);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
