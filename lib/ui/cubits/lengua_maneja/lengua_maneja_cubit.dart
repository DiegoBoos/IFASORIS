import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/usecases/lengua_maneja/lengua_maneja_exports.dart';

part 'lengua_maneja_state.dart';

class LenguaManejaCubit extends Cubit<LenguasManejaState> {
  final LenguaManejaUsecaseDB lenguaManejaUsecaseDB;

  LenguaManejaCubit({required this.lenguaManejaUsecaseDB})
      : super(LenguasManejaInitial());

  void getLenguasManejaDB() async {
    final result = await lenguaManejaUsecaseDB.getLenguasManejaUsecase();
    result.fold((failure) => emit(LenguasManejaError(failure.properties.first)),
        (data) => emit(LenguasManejaLoaded(data)));
  }
}
