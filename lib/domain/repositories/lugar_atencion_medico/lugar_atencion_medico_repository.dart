import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lugar_atencion_medico.dart';

abstract class LugarAtencionMedicoRepository {
  Future<Either<Failure, List<LugarAtencionMedicoEntity>>>
      getLugaresAtencionMedicoRepository();
}
