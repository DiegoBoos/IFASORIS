import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/afiliado_response_model.dart';

abstract class AfiliadoRepository {
  Future<Either<Failure, AfiliadoResponseModel>> getAfiliadosRepository(
      int dtoId);
}
