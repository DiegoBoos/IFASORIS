import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tipo_sanitario_vivienda_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_sanitario_vivienda_entity.dart';
import '../../../domain/repositories/tipo_sanitario_vivienda/tipo_sanitario_vivienda_repository_db.dart';
import '../../datasources/local/tipo_sanitario_vivienda_local_ds.dart';

class TipoSanitarioViviendaRepositoryDBImpl
    implements TipoSanitarioViviendaRepositoryDB {
  final TipoSanitarioViviendaLocalDataSource
      tipoSanitarioViviendaLocalDataSource;

  TipoSanitarioViviendaRepositoryDBImpl(
      {required this.tipoSanitarioViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<TipoSanitarioViviendaEntity>>>
      getTiposSanitarioRepositoryDB() async {
    try {
      final result =
          await tipoSanitarioViviendaLocalDataSource.getTiposSanitario();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTipoSanitarioViviendaRepositoryDB(
      TipoSanitarioViviendaEntity tipoSanitarioVivienda) async {
    try {
      final result = await tipoSanitarioViviendaLocalDataSource
          .saveTipoSanitarioVivienda(tipoSanitarioVivienda);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiposSanitarioViviendaRepositoryDB(
      int datoViviendaId, List<LstTiposSanitario> lstTiposSanitario) async {
    try {
      final result = await tipoSanitarioViviendaLocalDataSource
          .saveTiposSanitarioVivienda(datoViviendaId, lstTiposSanitario);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstTiposSanitario>>>
      getTiposSanitarioViviendaRepositoryDB(int? datoViviendaId) async {
    try {
      final result = await tipoSanitarioViviendaLocalDataSource
          .getTiposSanitarioVivienda(datoViviendaId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
