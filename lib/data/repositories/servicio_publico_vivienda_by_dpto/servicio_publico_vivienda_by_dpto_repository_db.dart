import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/servicio_publico_vivienda_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/servicio_publico_vivienda_entity.dart';
import '../../../domain/repositories/servicio_publico_vivienda_by_dpto/servicio_publico_vivienda_by_dpto_repository_db.dart';
import '../../datasources/local/servicio_publico_vivienda_by_dpto_local_ds.dart';

class ServicioPublicoViviendaByDptoRepositoryDBImpl
    implements ServicioPublicoViviendaByDptoRepositoryDB {
  final ServicioPublicoViviendaByDptoLocalDataSource
      servicioPublicoViviendaByDptoLocalDataSource;

  ServicioPublicoViviendaByDptoRepositoryDBImpl(
      {required this.servicioPublicoViviendaByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<ServicioPublicoViviendaEntity>>>
      getServiciosPublicosViviendaByDptoRepositoryDB() async {
    try {
      final result = await servicioPublicoViviendaByDptoLocalDataSource
          .getServiciosPublicosViviendaByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveServicioPublicoViviendaByDptoRepositoryDB(
      ServicioPublicoViviendaEntity servicioPublicoVivienda) async {
    try {
      final result = await servicioPublicoViviendaByDptoLocalDataSource
          .saveServicioPublicoViviendaByDpto(servicioPublicoVivienda);
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
      final result = await servicioPublicoViviendaByDptoLocalDataSource
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
      final result = await servicioPublicoViviendaByDptoLocalDataSource
          .getServiciosPublicosVivienda(datoViviendaId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
