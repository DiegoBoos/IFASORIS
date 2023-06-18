import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/parentesco_entity.dart';
import '../../../domain/usecases/parentesco/parentesco_db_usecase.dart';

part 'parentesco_state.dart';

class ParentescoCubit extends Cubit<ParentescosState> {
  final ParentescoUsecaseDB parentescoUsecaseDB;

  ParentescoCubit({required this.parentescoUsecaseDB})
      : super(ParentescosInitial());

  void getParentescosDB() async {
    final result = await parentescoUsecaseDB.getParentescosUsecaseDB();
    result.fold((failure) => emit(ParentescosError(failure.properties.first)),
        (data) => emit(ParentescosLoaded(data)));
  }
}
