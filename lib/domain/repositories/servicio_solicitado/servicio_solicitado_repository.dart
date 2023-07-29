import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/servicio_solicitado_entity.dart';

abstract class ServicioSolicitadoRepository {
  Future<Either<Failure, List<ServicioSolicitadoEntity>>>
      getServiciosSolicitadosRepository();
}
