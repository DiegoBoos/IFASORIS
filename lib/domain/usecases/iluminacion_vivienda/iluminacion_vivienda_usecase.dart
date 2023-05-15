import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/iluminacion_vivienda_entity.dart';
import '../../repositories/iluminacion_vivienda/iluminacion_vivienda_repository.dart';

class IluminacionViviendaUsecase {
  final IluminacionViviendaRepository repository;

  IluminacionViviendaUsecase(this.repository);

  Future<Either<Failure, List<IluminacionViviendaEntity>>>
      getIluminacionesViviendaUsecase() {
    return repository.getIluminacionesViviendaRepository();
  }
}
