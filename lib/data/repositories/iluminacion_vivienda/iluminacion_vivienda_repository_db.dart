import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/iluminacion_vivienda_entity.dart';
import '../../../domain/repositories/iluminacion_vivienda/iluminacion_vivienda_repository_db.dart';
import '../../datasources/local/iluminacion_vivienda_local_ds.dart';

class IluminacionViviendaRepositoryDBImpl
    implements IluminacionViviendaRepositoryDB {
  final IluminacionViviendaLocalDataSource iluminacionViviendaLocalDataSource;

  IluminacionViviendaRepositoryDBImpl(
      {required this.iluminacionViviendaLocalDataSource});

  @override
  Future<Either<Failure, List<IluminacionViviendaEntity>>>
      getIluminacionesViviendaRepositoryDB() async {
    try {
      final result =
          await iluminacionViviendaLocalDataSource.getIluminacionesVivienda();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveIluminacionViviendaRepositoryDB(
      IluminacionViviendaEntity iluminacionVivienda) async {
    try {
      final result = await iluminacionViviendaLocalDataSource
          .saveIluminacionVivienda(iluminacionVivienda);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
