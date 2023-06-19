import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifasoris/domain/usecases/nombre_lengua_materna/nombre_lengua_materna_exports.dart';

part 'nombre_lengua_materna_state.dart';

class NombreLenguaMaternaCubit extends Cubit<NombresLenguasMaternaState> {
  final NombreLenguaMaternaUsecaseDB nombreLenguaMaternaUsecaseDB;

  NombreLenguaMaternaCubit({required this.nombreLenguaMaternaUsecaseDB})
      : super(NombresLenguasMaternaInitial());

  void getNombresLenguasMaternaDB() async {
    final result =
        await nombreLenguaMaternaUsecaseDB.getNombresLenguasMaternaUsecase();
    result.fold(
        (failure) => emit(NombresLenguasMaternaError(failure.properties.first)),
        (data) => emit(NombresLenguasMaternaLoaded(data)));
  }
}
