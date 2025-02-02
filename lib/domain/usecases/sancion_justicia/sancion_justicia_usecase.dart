import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/sancion_justicia.dart';
import '../../repositories/sancion_justicia/sancion_justicia_repository.dart';

class SancionJusticiaUsecase {
  final SancionJusticiaRepository repository;

  SancionJusticiaUsecase(this.repository);

  Future<Either<Failure, List<SancionJusticiaEntity>>>
      getSancionesJusticiaUsecase() {
    return repository.getSancionesJusticiaRepository();
  }
}
