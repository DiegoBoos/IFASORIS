import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/resguardo_entity.dart';
import '../../../domain/usecases/resguardo/resguardo_db_usecase.dart';

part 'resguardo_state.dart';

class ResguardoCubit extends Cubit<ResguardosState> {
  final ResguardoUsecaseDB resguardoUsecaseDB;

  ResguardoCubit({required this.resguardoUsecaseDB})
      : super(ResguardosInitial());

  void getResguardosDB() async {
    final result = await resguardoUsecaseDB.getResguardosUsecaseDB();
    result.fold((failure) => emit(ResguardosError(failure.properties.first)),
        (data) => emit(ResguardosLoaded(data)));
  }
}
