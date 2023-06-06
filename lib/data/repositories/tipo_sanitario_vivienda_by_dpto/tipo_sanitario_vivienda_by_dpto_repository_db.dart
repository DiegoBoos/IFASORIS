import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tipo_sanitario_vivienda_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_sanitario_vivienda_entity.dart';
import '../../../domain/repositories/tipo_sanitario_vivienda_by_dpto/tipo_sanitario_vivienda_by_dpto_repository_db.dart';
import '../../datasources/local/tipo_sanitario_vivienda_by_dpto_local_ds.dart';

class TipoSanitarioViviendaByDptoRepositoryDBImpl
    implements TipoSanitarioViviendaByDptoRepositoryDB {
  final TipoSanitarioViviendaByDptoLocalDataSource
      tipoSanitarioViviendaByDptoLocalDataSource;

  TipoSanitarioViviendaByDptoRepositoryDBImpl(
      {required this.tipoSanitarioViviendaByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<TipoSanitarioViviendaEntity>>>
      getTiposSanitarioViviendaByDptoRepositoryDB() async {
    try {
      final result = await tipoSanitarioViviendaByDptoLocalDataSource
          .getTiposSanitarioViviendaByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTipoSanitarioViviendaByDptoRepositoryDB(
      TipoSanitarioViviendaEntity tipoSanitarioViviendaByDpto) async {
    try {
      final result = await tipoSanitarioViviendaByDptoLocalDataSource
          .saveTipoSanitarioViviendaByDpto(tipoSanitarioViviendaByDpto);
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
      final result = await tipoSanitarioViviendaByDptoLocalDataSource
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
      final result = await tipoSanitarioViviendaByDptoLocalDataSource
          .getTiposSanitarioVivienda(datoViviendaId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
