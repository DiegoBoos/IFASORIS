import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ventilacion_vivienda.dart';

abstract class VentilacionViviendaRepositoryDB {
  Future<Either<Failure, int>> saveVentilacionViviendaRepositoryDB(
      VentilacionViviendaEntity ventilacionVivienda);

  Future<Either<Failure, List<VentilacionViviendaEntity>>>
      getVentilacionesViviendaRepositoryDB();
}
