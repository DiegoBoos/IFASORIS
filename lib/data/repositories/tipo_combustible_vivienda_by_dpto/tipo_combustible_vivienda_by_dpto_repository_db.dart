import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_combustible_vivienda_entity.dart';
import '../../../domain/repositories/tipo_combustible_vivienda_by_dpto/tipo_combustible_vivienda_by_dpto_repository_db.dart';
import '../../datasources/local/tipo_combustible_vivienda_by_dpto_local_ds.dart';

class TipoCombustibleViviendaByDptoRepositoryDBImpl
    implements TipoCombustibleViviendaByDptoRepositoryDB {
  final TipoCombustibleViviendaByDptoLocalDataSource
      tipoCombustibleViviendaByDptoLocalDataSource;

  TipoCombustibleViviendaByDptoRepositoryDBImpl(
      {required this.tipoCombustibleViviendaByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<TipoCombustibleViviendaEntity>>>
      getTiposCombustibleViviendaByDptoRepositoryDB() async {
    try {
      final result = await tipoCombustibleViviendaByDptoLocalDataSource
          .getTiposCombustibleViviendaByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTipoCombustibleViviendaByDptoRepositoryDB(
      TipoCombustibleViviendaEntity tipoCombustibleViviendaByDpto) async {
    try {
      final result = await tipoCombustibleViviendaByDptoLocalDataSource
          .saveTipoCombustibleViviendaByDpto(tipoCombustibleViviendaByDpto);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
