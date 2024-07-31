import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/religion_profesa/religion_profesa_repository.dart';
import '../../datasources/remote/religion_profesa_remote_ds.dart';
import '../../models/religion_profesa.dart';

class ReligionProfesaRepositoryImpl implements ReligionProfesaRepository {
  final ReligionProfesaRemoteDataSource religionProfesaRemoteDataSource;

  ReligionProfesaRepositoryImpl(
      {required this.religionProfesaRemoteDataSource});

  @override
  Future<Either<Failure, List<ReligionProfesaModel>>>
      getReligionesProfesaRepository() async {
    try {
      final result =
          await religionProfesaRemoteDataSource.getReligionesProfesa();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
