import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cuarto_vivienda.dart';
import '../../repositories/cuarto_vivienda/cuarto_vivienda_repository.dart';

class CuartoViviendaUsecase {
  final CuartoViviendaRepository repository;

  CuartoViviendaUsecase(this.repository);

  Future<Either<Failure, List<CuartoViviendaEntity>>>
      getCuartosViviendaUsecase() {
    return repository.getCuartosViviendaRepository();
  }
}
