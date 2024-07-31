import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/iluminacion_vivienda.dart';

abstract class IluminacionViviendaRepository {
  Future<Either<Failure, List<IluminacionViviendaEntity>>>
      getIluminacionesViviendaRepository();
}
