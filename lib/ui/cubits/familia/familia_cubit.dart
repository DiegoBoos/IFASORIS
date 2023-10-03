import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/familia/familia_db_usecase.dart';

import '../../../domain/entities/familia_entity.dart';
part 'familia_state.dart';

class FamiliaCubit extends Cubit<FamiliaState> {
  final FamiliaUsecaseDB familiaUsecaseDB;
  FamiliaCubit({required this.familiaUsecaseDB}) : super(FamiliaInitial());

  void initState() => emit(FamiliaInitial());

  Future<FamiliaEntity?> createFamiliaDB(FamiliaEntity familia) async {
    final result = await familiaUsecaseDB.createFamiliaUsecaseDB(familia);
    return result.fold((failure) => null, (data) => familia);
  }

  Future<int> deleteAfiliadoFamilia(int fkAfiliadoId) async {
    final result =
        await familiaUsecaseDB.deleteAfiliadoFamiliaUsecaseDB(fkAfiliadoId);
    return result.fold((failure) => 0, (data) => data);
  }
}
