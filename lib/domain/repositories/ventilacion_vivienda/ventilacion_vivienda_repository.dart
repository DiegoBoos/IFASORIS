import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ventilacion_vivienda.dart';

abstract class VentilacionViviendaRepository {
  Future<Either<Failure, List<VentilacionViviendaEntity>>>
      getVentilacionesViviendaRepository();
}
