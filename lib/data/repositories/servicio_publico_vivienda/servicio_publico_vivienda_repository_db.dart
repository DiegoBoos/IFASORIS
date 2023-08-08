import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/servicio_publico_vivienda_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/servicio_publico_vivienda_entity.dart';
import '../../../domain/repositories/servicio_publico_vivienda/servicio_publico_vivienda_repository_db.dart';
import '../../datasources/local/servicio_publico_vivienda_local_ds.dart';

class ServicioPublicoViviendaRepositoryDBImpl
    implements ServicioPublicoViviendaRepositoryDB {
  final ServicioPublicoViviendaLocalDataSource
      servicioPublicoViviendaLocalDataSource;

  ServicioPublicoViviendaRepositoryDBImpl(
      {required this.servicioPublicoViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<ServicioPublicoViviendaEntity>>>
      getServiciosPublicosRepositoryDB() async {
    try {
      final result =
          await servicioPublicoViviendaLocalDataSource.getServiciosPublicos();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveServicioPublicoViviendaRepositoryDB(
      ServicioPublicoViviendaEntity servicioPublicoVivienda) async {
    try {
      final result = await servicioPublicoViviendaLocalDataSource
          .saveServicioPublicoVivienda(servicioPublicoVivienda);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveServiciosPublicosViviendaRepositoryDB(
      int datoViviendaId, List<LstServPublico> lstServPublicos) async {
    try {
      final result = await servicioPublicoViviendaLocalDataSource
          .saveServiciosPublicosVivienda(datoViviendaId, lstServPublicos);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstServPublico>>>
      getServiciosPublicosViviendaRepositoryDB(int? datoViviendaId) async {
    try {
      final result = await servicioPublicoViviendaLocalDataSource
          .getServiciosPublicosVivienda(datoViviendaId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
