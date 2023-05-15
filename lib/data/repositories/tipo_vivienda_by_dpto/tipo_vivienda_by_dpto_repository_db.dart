import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_vivienda_entity.dart';
import '../../../domain/repositories/tipo_vivienda_by_dpto/tipo_vivienda_by_dpto_repository_db.dart';
import '../../datasources/local/tipo_vivienda_by_dpto_local_ds.dart';

class TipoViviendaByDptoRepositoryDBImpl
    implements TipoViviendaByDptoRepositoryDB {
  final TipoViviendaByDptoLocalDataSource tipoViviendaByDptoLocalDataSource;

  TipoViviendaByDptoRepositoryDBImpl(
      {required this.tipoViviendaByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<TipoViviendaEntity>>>
      getTiposViviendaByDptoRepositoryDB() async {
    try {
      final result =
          await tipoViviendaByDptoLocalDataSource.getTiposViviendaByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTipoViviendaByDptoRepositoryDB(
      TipoViviendaEntity tipoVivienda) async {
    try {
      final result = await tipoViviendaByDptoLocalDataSource
          .saveTipoViviendaByDpto(tipoVivienda);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
