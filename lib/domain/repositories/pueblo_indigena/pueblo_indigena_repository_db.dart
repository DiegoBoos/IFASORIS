import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/pueblo_indigena_entity.dart';

abstract class PuebloIndigenaRepositoryDB {
  Future<Either<Failure, int>> savePuebloIndigenaRepositoryDB(
      PuebloIndigenaEntity puebloIndigena);

  Future<Either<Failure, List<PuebloIndigenaEntity>>>
      getPueblosIndigenasRepositoryDB();
}
