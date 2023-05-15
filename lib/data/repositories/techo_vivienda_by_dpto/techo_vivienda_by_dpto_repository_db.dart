import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/techo_vivienda_entity.dart';
import '../../../domain/repositories/techo_vivienda_by_dpto/techo_vivienda_by_dpto_repository_db.dart';
import '../../datasources/local/techo_vivienda_by_dpto_local_ds.dart';

class TechoViviendaByDptoRepositoryDBImpl
    implements TechoViviendaByDptoRepositoryDB {
  final TechoViviendaByDptoLocalDataSource techoViviendaByDptoLocalDataSource;

  TechoViviendaByDptoRepositoryDBImpl(
      {required this.techoViviendaByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<TechoViviendaEntity>>>
      getTechosViviendaByDptoRepositoryDB() async {
    try {
      final result =
          await techoViviendaByDptoLocalDataSource.getTechosViviendaByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTechoViviendaByDptoRepositoryDB(
      TechoViviendaEntity techoVivienda) async {
    try {
      final result = await techoViviendaByDptoLocalDataSource
          .saveTechoViviendaByDpto(techoVivienda);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
