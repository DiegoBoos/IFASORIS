import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nro_cuarto_vivienda.dart';

abstract class NroCuartoViviendaRepositoryDB {
  Future<Either<Failure, int>> saveNroCuartoViviendaRepositoryDB(
      NroCuartoViviendaEntity nroCuartoVivienda);

  Future<Either<Failure, List<NroCuartoViviendaEntity>>>
      getNroCuartosViviendaRepositoryDB();
}
