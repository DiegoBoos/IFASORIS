import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/ficha_entity.dart';
import '../../../domain/usecases/ficha/ficha_usecase.dart';

part 'ficha_event.dart';
part 'ficha_state.dart';

class FichaBloc extends Bloc<FichaEvent, FichaState> {
  final FichaUsecase ficha;
  FichaBloc({required this.ficha}) : super(FichaInitial()) {
    on<NewFicha>((event, emit) {
      emit(FichaLoading());
      _createFicha(event, emit);
    });
  }
  _createFicha(event, emit) async {
    final ficha = event.ficha;

    final result = await ficha.createFichaUsecase(ficha);
    result.fold((failure) {
      emit(FichaError(failure.properties.first));
    }, (data) {
      emit(FichaCreated(data));
    });
  }
}
