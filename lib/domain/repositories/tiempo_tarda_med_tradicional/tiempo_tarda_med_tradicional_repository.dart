import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tiempo_tarda_med_tradicional.dart';

abstract class TiempoTardaMedTradicionalRepository {
  Future<Either<Failure, List<TiempoTardaMedTradicionalEntity>>>
      getTiemposTardaMedTradicionalRepository();
}
