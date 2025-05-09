import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/usuario_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UsuarioEntity>> logInRepository(UsuarioEntity usuario);

  Future<Either<Failure, String>> cambioDispositivoRepositoryDB(
      String userName, String idEquipo);
}
