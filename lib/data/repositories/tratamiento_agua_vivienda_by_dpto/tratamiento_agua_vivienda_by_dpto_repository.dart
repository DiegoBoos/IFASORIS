import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tratamiento_agua_vivienda_entity.dart';
import '../../../domain/repositories/tratamiento_agua_vivienda_by_dpto/tratamiento_agua_vivienda_by_dpto_repository.dart';
import '../../datasources/remote/tratamiento_agua_vivienda_by_dpto_remote_ds.dart';

class TratamientoAguaViviendaByDptoRepositoryImpl
    implements TratamientoAguaViviendaByDptoRepository {
  final TratamientoAguaViviendaByDptoRemoteDataSource
      tratamientoAguaViviendaByDptoRemoteDataSource;

  TratamientoAguaViviendaByDptoRepositoryImpl(
      {required this.tratamientoAguaViviendaByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<TratamientoAguaViviendaEntity>>>
      getTratamientosAguaViviendaByDptoRepository(int dtoId) async {
    try {
      final result = await tratamientoAguaViviendaByDptoRemoteDataSource
          .getTratamientosAguaViviendaByDpto(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
