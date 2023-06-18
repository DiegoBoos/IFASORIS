import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/pueblo_indigena_entity.dart';

abstract class PuebloIndigenaByDptoRepositoryDB {
  Future<Either<Failure, int>> savePuebloIndigenaByDptoRepositoryDB(
      PuebloIndigenaEntity puebloIndigena);

  Future<Either<Failure, List<PuebloIndigenaEntity>>>
      getPueblosIndigenasByDptoRepositoryDB();
}
