import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/parentesco.dart';

abstract class ParentescoRepository {
  Future<Either<Failure, List<ParentescoEntity>>> getParentescosRepository();
}
