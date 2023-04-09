import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_ca_entity.dart';

abstract class MedioUtilizaCARepositoryDB {
  Future<Either<Failure, int>> saveMedioUtilizaCARepositoryDB(
      MedioUtilizaCAEntity medioUtilizaCA);

  Future<Either<Failure, List<MedioUtilizaCAEntity>>>
      getMediosUtilizaCARepositoryDB();
}
