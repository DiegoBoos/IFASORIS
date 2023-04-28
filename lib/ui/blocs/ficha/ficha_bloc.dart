import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/ficha/ficha_exports.dart';

part 'ficha_event.dart';
part 'ficha_state.dart';

class FichaBloc extends Bloc<FichaEvent, FichasState> {
  final FichaUsecaseDB fichaUsecaseDB;
  FichaBloc({required this.fichaUsecaseDB}) : super(FichasInitial()) {
    on<LoadFichas>((event, emit) async {
      emit(FichasLoading());
      await _loadFichas(event, emit);
    });
  }

  _loadFichas(event, emit) async {
    final result = await fichaUsecaseDB.loadFichasUsecaseDB();
    result.fold((failure) {
      emit(FichasError(failure.properties.first));
    }, (data) {
      emit(FichasLoaded(data));
    });
  }
}
