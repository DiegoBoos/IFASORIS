import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/servicio_publico_vivienda.dart';

abstract class ServicioPublicoViviendaRepository {
  Future<Either<Failure, List<ServicioPublicoViviendaEntity>>>
      getServiciosPublicosViviendaRepository(int dtoId);
}
