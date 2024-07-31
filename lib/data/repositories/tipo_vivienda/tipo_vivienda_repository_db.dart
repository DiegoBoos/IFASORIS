import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_vivienda.dart';
import '../../../domain/repositories/tipo_vivienda/tipo_vivienda_repository_db.dart';
import '../../datasources/local/tipo_vivienda_local_ds.dart';
import '../../models/tipo_vivienda.dart';

class TipoViviendaRepositoryDBImpl implements TipoViviendaRepositoryDB {
  final TipoViviendaLocalDataSource tipoViviendaLocalDataSource;

  TipoViviendaRepositoryDBImpl({required this.tipoViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<TipoViviendaModel>>>
      getTiposViviendaRepositoryDB() async {
    try {
      final result = await tipoViviendaLocalDataSource.getTiposVivienda();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTipoViviendaRepositoryDB(
      TipoViviendaEntity tipoVivienda) async {
    try {
      final tipoViviendaModel = TipoViviendaModel.fromEntity(tipoVivienda);
      final result =
          await tipoViviendaLocalDataSource.saveTipoVivienda(tipoViviendaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
