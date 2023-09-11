import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cuarto_vivienda_entity.dart';
import '../../repositories/cuarto_vivienda/cuarto_vivienda_repository.dart';

class NroCuartoViviendaUsecase {
  final NroCuartoViviendaRepository repository;

  NroCuartoViviendaUsecase(this.repository);

  Future<Either<Failure, List<NroCuartoViviendaEntity>>>
      getNroCuartosViviendaUsecase() {
    return repository.getNroCuartosViviendaRepository();
  }
}
