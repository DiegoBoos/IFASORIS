import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/consumo_alcohol.dart';
import '../../repositories/consumo_alcohol/consumo_alcohol_repository.dart';

class ConsumoAlcoholUsecase {
  final ConsumoAlcoholRepository repository;

  ConsumoAlcoholUsecase(this.repository);

  Future<Either<Failure, List<ConsumoAlcoholEntity>>>
      getConsumosAlcoholUsecase() {
    return repository.getConsumosAlcoholRepository();
  }
}
