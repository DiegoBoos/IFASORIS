import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/piso_vivienda_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/piso_vivienda_entity.dart';
import '../../../domain/repositories/piso_vivienda/piso_vivienda_repository_db.dart';
import '../../datasources/local/piso_vivienda_local_ds.dart';

class PisoViviendaRepositoryDBImpl implements PisoViviendaRepositoryDB {
  final PisoViviendaLocalDataSource pisoViviendaLocalDataSource;

  PisoViviendaRepositoryDBImpl({required this.pisoViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<PisoViviendaEntity>>>
      getPisosViviendaRepositoryDB() async {
    try {
      final result = await pisoViviendaLocalDataSource.getPisosVivienda();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePisoViviendaRepositoryDB(
      PisoViviendaEntity pisoVivienda) async {
    try {
      final result =
          await pisoViviendaLocalDataSource.savePisoVivienda(pisoVivienda);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstPiso>>> getPisosViviendaViviendaRepositoryDB(
      int? datoViviendaId) async {
    try {
      final result = await pisoViviendaLocalDataSource
          .getPisosViviendaVivienda(datoViviendaId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePisosViviendaRepositoryDB(
      int datoViviendaId, List<LstPiso> lstPiso) async {
    try {
      final result = await pisoViviendaLocalDataSource.savePisosVivienda(
          datoViviendaId, lstPiso);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
