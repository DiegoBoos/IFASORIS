import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/ventilacion_vivienda_entity.dart';
import '../../../domain/repositories/ventilacion_vivienda/ventilacion_vivienda_repository_db.dart';
import '../../datasources/local/ventilacion_vivienda_local_ds.dart';

class VentilacionViviendaRepositoryDBImpl
    implements VentilacionViviendaRepositoryDB {
  final VentilacionViviendaLocalDataSource ventilacionViviendaLocalDataSource;

  VentilacionViviendaRepositoryDBImpl(
      {required this.ventilacionViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<VentilacionViviendaEntity>>>
      getVentilacionesViviendaRepositoryDB() async {
    try {
      final result =
          await ventilacionViviendaLocalDataSource.getVentilacionesVivienda();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveVentilacionViviendaRepositoryDB(
      VentilacionViviendaEntity ventilacionVivienda) async {
    try {
      final result = await ventilacionViviendaLocalDataSource
          .saveVentilacionVivienda(ventilacionVivienda);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
