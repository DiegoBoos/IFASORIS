import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nro_cuarto_vivienda.dart';
import '../../repositories/nro_cuarto_vivienda/nro_cuarto_vivienda_repository.dart';

class NroCuartoViviendaUsecase {
  final NroCuartoViviendaRepository repository;

  NroCuartoViviendaUsecase(this.repository);

  Future<Either<Failure, List<NroCuartoViviendaEntity>>>
      getNroCuartosViviendaUsecase() {
    return repository.getNroCuartosViviendaRepository();
  }
}
