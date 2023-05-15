import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/piso_vivienda_entity.dart';
import '../../../domain/repositories/piso_vivienda_by_dpto/piso_vivienda_by_dpto_repository_db.dart';
import '../../datasources/local/piso_vivienda_by_dpto_local_ds.dart';

class PisoViviendaByDptoRepositoryDBImpl
    implements PisoViviendaByDptoRepositoryDB {
  final PisoViviendaByDptoLocalDataSource pisoViviendaByDptoLocalDataSource;

  PisoViviendaByDptoRepositoryDBImpl(
      {required this.pisoViviendaByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<PisoViviendaEntity>>>
      getPisosViviendaByDptoRepositoryDB() async {
    try {
      final result =
          await pisoViviendaByDptoLocalDataSource.getPisosViviendaByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePisoViviendaByDptoRepositoryDB(
      PisoViviendaEntity pisoVivienda) async {
    try {
      final result = await pisoViviendaByDptoLocalDataSource
          .savePisoViviendaByDpto(pisoVivienda);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
