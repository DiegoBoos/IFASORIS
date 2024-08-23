import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/servicio_publico_vivienda.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/servicio_publico_vivienda.dart';
import '../../../domain/repositories/servicio_publico_vivienda/servicio_publico_vivienda_repository_db.dart';
import '../../datasources/local/servicio_publico_vivienda_local_ds.dart';

class ServicioPublicoViviendaRepositoryDBImpl
    implements ServicioPublicoViviendaRepositoryDB {
  final ServicioPublicoViviendaLocalDataSource
      servicioPublicoViviendaLocalDataSource;

  ServicioPublicoViviendaRepositoryDBImpl(
      {required this.servicioPublicoViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<ServicioPublicoViviendaModel>>>
      getServiciosPublicosRepositoryDB() async {
    try {
      final result =
          await servicioPublicoViviendaLocalDataSource.getServiciosPublicos();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveServicioPublicoViviendaRepositoryDB(
      ServicioPublicoViviendaEntity servicioPublicoVivienda) async {
    try {
      final servicioPublicoViviendaModel =
          ServicioPublicoViviendaModel.fromEntity(servicioPublicoVivienda);
      final result = await servicioPublicoViviendaLocalDataSource
          .saveServicioPublicoVivienda(servicioPublicoViviendaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveServiciosPublicosViviendaRepositoryDB(
      int datoViviendaId, List<LstServPublico> lstServPublico) async {
    try {
      final result = await servicioPublicoViviendaLocalDataSource
          .saveServiciosPublicosVivienda(datoViviendaId, lstServPublico);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<LstServPublico>>>
      getServiciosPublicosViviendaRepositoryDB(int? datoViviendaId) async {
    try {
      final result = await servicioPublicoViviendaLocalDataSource
          .getServiciosPublicosVivienda(datoViviendaId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
