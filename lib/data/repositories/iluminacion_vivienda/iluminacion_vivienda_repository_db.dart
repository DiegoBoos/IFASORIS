import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/iluminacion_vivienda.dart';
import '../../../domain/repositories/iluminacion_vivienda/iluminacion_vivienda_repository_db.dart';
import '../../datasources/local/iluminacion_vivienda_local_ds.dart';
import '../../models/iluminacion_vivienda.dart';

class IluminacionViviendaRepositoryDBImpl
    implements IluminacionViviendaRepositoryDB {
  final IluminacionViviendaLocalDataSource iluminacionViviendaLocalDataSource;

  IluminacionViviendaRepositoryDBImpl(
      {required this.iluminacionViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<IluminacionViviendaModel>>>
      getIluminacionesViviendaRepositoryDB() async {
    try {
      final result =
          await iluminacionViviendaLocalDataSource.getIluminacionesVivienda();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveIluminacionViviendaRepositoryDB(
      IluminacionViviendaEntity iluminacionVivienda) async {
    try {
      final iluminacionViviendaModel =
          IluminacionViviendaModel.fromEntity(iluminacionVivienda);
      final result = await iluminacionViviendaLocalDataSource
          .saveIluminacionVivienda(iluminacionViviendaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
