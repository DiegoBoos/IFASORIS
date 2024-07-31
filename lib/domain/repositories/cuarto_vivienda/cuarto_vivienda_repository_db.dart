import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cuarto_vivienda.dart';

abstract class CuartoViviendaRepositoryDB {
  Future<Either<Failure, int>> saveCuartoViviendaRepositoryDB(
      CuartoViviendaEntity cuartoVivienda);

  Future<Either<Failure, List<CuartoViviendaEntity>>>
      getCuartosViviendaRepositoryDB();
}
