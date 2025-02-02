import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lengua_maneja.dart';
import '../../repositories/lengua_maneja/lengua_maneja_repository.dart';

class LenguaManejaUsecase {
  final LenguaManejaRepository repository;

  LenguaManejaUsecase(this.repository);

  Future<Either<Failure, List<LenguaManejaEntity>>> getLenguasManejaUsecase() {
    return repository.getLenguasManejaRepository();
  }
}
