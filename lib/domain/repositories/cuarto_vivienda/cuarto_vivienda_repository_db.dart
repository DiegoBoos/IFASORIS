import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cuarto_vivienda_entity.dart';

abstract class NroCuartoViviendaRepositoryDB {
  Future<Either<Failure, int>> saveNroCuartoViviendaRepositoryDB(
      NroCuartoViviendaEntity nroCuartoVivienda);

  Future<Either<Failure, List<NroCuartoViviendaEntity>>>
      getNroCuartosViviendaRepositoryDB();
}
