import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/consumo_alcohol.dart';

abstract class ConsumoAlcoholRepository {
  Future<Either<Failure, List<ConsumoAlcoholEntity>>>
      getConsumosAlcoholRepository();
}
