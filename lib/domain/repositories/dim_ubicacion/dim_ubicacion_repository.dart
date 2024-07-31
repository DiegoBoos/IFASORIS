import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dim_ubicacion.dart';

abstract class DimUbicacionRepository {
  Future<Either<Failure, DimUbicacionEntity>> uploadDimUbicacionRepository();
}
