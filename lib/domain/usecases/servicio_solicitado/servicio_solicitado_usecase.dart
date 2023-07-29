import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/servicio_solicitado_entity.dart';
import '../../repositories/servicio_solicitado/servicio_solicitado_repository.dart';

class ServicioSolicitadoUsecase {
  final ServicioSolicitadoRepository repository;

  ServicioSolicitadoUsecase(this.repository);

  Future<Either<Failure, List<ServicioSolicitadoEntity>>>
      getServiciosSolicitadosUsecase() {
    return repository.getServiciosSolicitadosRepository();
  }
}
