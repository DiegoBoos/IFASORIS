import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nro_cuarto_vivienda.dart';

abstract class NroCuartoViviendaRepository {
  Future<Either<Failure, List<NroCuartoViviendaEntity>>>
      getNroCuartosViviendaRepository();
}
