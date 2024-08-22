import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/nro_cuarto_vivienda.dart';
import '../../../domain/repositories/nro_cuarto_vivienda/nro_cuarto_vivienda_repository_db.dart';
import '../../datasources/local/nro_cuarto_vivienda_local_ds.dart';
import '../../models/nro_cuarto_vivienda.dart';

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
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveNroCuartoViviendaRepositoryDB(
      NroCuartoViviendaEntity nroCuartoVivienda) async {
    try {
      final nroCuartoViviendaModel =
          NroCuartoViviendaModel.fromEntity(nroCuartoVivienda);
      final result = await nroCuartoViviendaLocalDataSource
          .saveNroCuartoVivienda(nroCuartoViviendaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
