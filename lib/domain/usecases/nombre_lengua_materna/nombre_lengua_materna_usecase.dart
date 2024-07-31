import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nombre_lengua_materna.dart';
import '../../repositories/nombre_lengua_materna/nombre_lengua_materna_repository.dart';

class NombreLenguaMaternaUsecase {
  final NombreLenguaMaternaRepository repository;

  NombreLenguaMaternaUsecase(this.repository);

  Future<Either<Failure, List<NombreLenguaMaternaEntity>>>
      getNombresLenguasMaternaUsecase(int dtoId) {
    return repository.getNombresLenguasMaternaRepository(dtoId);
  }
}
