import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/usuario.dart';

abstract class AuthRepository {
  Future<Either<Failure, UsuarioEntity>> logInRepository(UsuarioEntity usuario);

  Future<Either<Failure, String>> cambioDispositivoRepositoryDB(
      String userName, String idEquipo);

  Future<Either<Failure, Map<String, dynamic>>> registerRepository(
      UsuarioEntity usuario);
}
