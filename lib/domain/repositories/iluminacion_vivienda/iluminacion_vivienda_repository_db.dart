import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/iluminacion_vivienda.dart';

abstract class IluminacionViviendaRepositoryDB {
  Future<Either<Failure, int>> saveIluminacionViviendaRepositoryDB(
      IluminacionViviendaEntity iluminacionVivienda);

  Future<Either<Failure, List<IluminacionViviendaEntity>>>
      getIluminacionesViviendaRepositoryDB();
}
