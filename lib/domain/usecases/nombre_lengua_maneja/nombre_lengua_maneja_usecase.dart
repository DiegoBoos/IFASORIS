import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nombre_lengua_maneja_entity.dart';
import '../../repositories/nombre_lengua_maneja/nombre_lengua_maneja_repository.dart';

class NombreLenguaManejaUsecase {
  final NombreLenguaManejaRepository repository;

  NombreLenguaManejaUsecase(this.repository);

  Future<Either<Failure, List<NombreLenguaManejaEntity>>>
      getNombresLenguasManejaUsecase() {
    return repository.getNombresLenguasManejaRepository();
  }
}
