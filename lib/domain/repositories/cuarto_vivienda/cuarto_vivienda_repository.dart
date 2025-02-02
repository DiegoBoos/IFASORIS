import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cuarto_vivienda.dart';

abstract class CuartoViviendaRepository {
  Future<Either<Failure, List<CuartoViviendaEntity>>>
      getCuartosViviendaRepository();
}
