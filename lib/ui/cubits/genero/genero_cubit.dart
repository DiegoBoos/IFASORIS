import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/genero.dart';
import '../../../domain/usecases/genero/genero_db_usecase.dart';

part 'genero_state.dart';

class GeneroCubit extends Cubit<GenerosState> {
  final GeneroUsecaseDB generoUsecaseDB;

  GeneroCubit({required this.generoUsecaseDB}) : super(GenerosInitial());

  void getGenerosDB() async {
    final result = await generoUsecaseDB.getGenerosUsecaseDB();
    result.fold((failure) => emit(GenerosError(failure.properties.first)),
        (data) => emit(GenerosLoaded(data)));
  }
}
