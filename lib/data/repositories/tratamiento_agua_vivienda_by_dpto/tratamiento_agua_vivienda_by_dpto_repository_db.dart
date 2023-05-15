import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tratamiento_agua_vivienda_entity.dart';
import '../../../domain/repositories/tratamiento_agua_vivienda_by_dpto/tratamiento_agua_vivienda_by_dpto_repository_db.dart';
import '../../datasources/local/tratamiento_agua_vivienda_by_dpto_local_ds.dart';

class TratamientoAguaViviendaByDptoRepositoryDBImpl
    implements TratamientoAguaViviendaByDptoRepositoryDB {
  final TratamientoAguaViviendaByDptoLocalDataSource
      tratamientoAguaViviendaByDptoLocalDataSource;

  TratamientoAguaViviendaByDptoRepositoryDBImpl(
      {required this.tratamientoAguaViviendaByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<TratamientoAguaViviendaEntity>>>
      getTratamientosAguaViviendaByDptoRepositoryDB() async {
    try {
      final result = await tratamientoAguaViviendaByDptoLocalDataSource
          .getTratamientosAguaViviendaByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTratamientoAguaViviendaByDptoRepositoryDB(
      TratamientoAguaViviendaEntity tratamientoAguaViviendaByDpto) async {
    try {
      final result = await tratamientoAguaViviendaByDptoLocalDataSource
          .saveTratamientoAguaViviendaByDpto(tratamientoAguaViviendaByDpto);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
