import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tiempo_tarda_ca.dart';

abstract class TiempoTardaCARepository {
  Future<Either<Failure, List<TiempoTardaCAEntity>>>
      getTiemposTardaCARepository();
}
