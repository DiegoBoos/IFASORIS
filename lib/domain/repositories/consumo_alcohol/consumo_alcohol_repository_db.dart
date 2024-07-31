import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/consumo_alcohol.dart';

abstract class ConsumoAlcoholRepositoryDB {
  Future<Either<Failure, int>> saveConsumoAlcoholRepositoryDB(
      ConsumoAlcoholEntity consumoAlcohol);

  Future<Either<Failure, List<ConsumoAlcoholEntity>>>
      getConsumosAlcoholRepositoryDB();
}
