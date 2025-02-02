import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_ca.dart';

abstract class MedioUtilizaCARepository {
  Future<Either<Failure, List<MedioUtilizaCAEntity>>>
      getMediosUtilizaCARepository(int ideDpto);
}
