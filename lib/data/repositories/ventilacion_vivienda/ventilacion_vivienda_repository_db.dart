import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/ventilacion_vivienda.dart';
import '../../../domain/repositories/ventilacion_vivienda/ventilacion_vivienda_repository_db.dart';
import '../../datasources/local/ventilacion_vivienda_local_ds.dart';
import '../../models/ventilacion_vivienda.dart';

class VentilacionViviendaRepositoryDBImpl
    implements VentilacionViviendaRepositoryDB {
  final VentilacionViviendaLocalDataSource ventilacionViviendaLocalDataSource;

  VentilacionViviendaRepositoryDBImpl(
      {required this.ventilacionViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<VentilacionViviendaModel>>>
      getVentilacionesViviendaRepositoryDB() async {
    try {
      final result =
          await ventilacionViviendaLocalDataSource.getVentilacionesVivienda();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveVentilacionViviendaRepositoryDB(
      VentilacionViviendaEntity ventilacionVivienda) async {
    try {
      final ventilacionViviendaModel =
          VentilacionViviendaModel.fromEntity(ventilacionVivienda);
      final result = await ventilacionViviendaLocalDataSource
          .saveVentilacionVivienda(ventilacionViviendaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
