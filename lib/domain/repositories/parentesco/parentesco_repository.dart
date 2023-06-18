import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/parentesco_entity.dart';

abstract class ParentescoRepository {
  Future<Either<Failure, List<ParentescoEntity>>> getParentescosRepository();
}
