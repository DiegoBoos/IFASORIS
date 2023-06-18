import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/usecases/nombre_lengua_maneja/nombre_lengua_maneja_exports.dart';

part 'nombre_lengua_maneja_state.dart';

class NombreLenguaManejaCubit extends Cubit<NombresLenguasManejaState> {
  final NombreLenguaManejaUsecaseDB nombreLenguaManejaUsecaseDB;

  NombreLenguaManejaCubit({required this.nombreLenguaManejaUsecaseDB})
      : super(NombresLenguasManejaInitial());

  void getNombresLenguasManejaDB() async {
    final result =
        await nombreLenguaManejaUsecaseDB.getNombresLenguasManejaUsecase();
    result.fold(
        (failure) => emit(NombresLenguasManejaError(failure.properties.first)),
        (data) => emit(NombresLenguasManejaLoaded(data)));
  }
}
