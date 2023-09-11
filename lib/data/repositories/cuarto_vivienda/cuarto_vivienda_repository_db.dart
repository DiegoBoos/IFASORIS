import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/cuarto_vivienda_entity.dart';
import '../../../domain/repositories/cuarto_vivienda/cuarto_vivienda_repository_db.dart';
import '../../datasources/local/cuarto_vivienda_local_ds.dart';

class NroCuartoViviendaRepositoryDBImpl
    implements NroCuartoViviendaRepositoryDB {
  final NroCuartoViviendaLocalDataSource nroCuartoViviendaLocalDataSource;

  NroCuartoViviendaRepositoryDBImpl(
      {required this.nroCuartoViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<NroCuartoViviendaEntity>>>
      getNroCuartosViviendaRepositoryDB() async {
    try {
      final result =
          await nroCuartoViviendaLocalDataSource.getNroCuartosVivienda();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveNroCuartoViviendaRepositoryDB(
      NroCuartoViviendaEntity nroCuartoVivienda) async {
    try {
      final result = await nroCuartoViviendaLocalDataSource
          .saveNroCuartoVivienda(nroCuartoVivienda);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
