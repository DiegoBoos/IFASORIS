import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/cuarto_vivienda.dart';
import '../../../domain/repositories/cuarto_vivienda/cuarto_vivienda_repository_db.dart';
import '../../datasources/local/cuarto_vivienda_local_ds.dart';
import '../../models/cuarto_vivienda.dart';

class CuartoViviendaRepositoryDBImpl implements CuartoViviendaRepositoryDB {
  final CuartoViviendaLocalDataSource cuartoViviendaLocalDataSource;

  CuartoViviendaRepositoryDBImpl({required this.cuartoViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<CuartoViviendaEntity>>>
      getCuartosViviendaRepositoryDB() async {
    try {
      final result = await cuartoViviendaLocalDataSource.getCuartosVivienda();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveCuartoViviendaRepositoryDB(
      CuartoViviendaEntity cuartoVivienda) async {
    try {
      final cuartoViviendaModel =
          CuartoViviendaModel.fromEntity(cuartoVivienda);
      final result = await cuartoViviendaLocalDataSource
          .saveCuartoVivienda(cuartoViviendaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
