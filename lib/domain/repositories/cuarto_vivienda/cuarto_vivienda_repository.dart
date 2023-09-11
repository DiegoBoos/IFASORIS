import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cuarto_vivienda_entity.dart';

abstract class NroCuartoViviendaRepository {
  Future<Either<Failure, List<NroCuartoViviendaEntity>>>
      getNroCuartosViviendaRepository();
}
