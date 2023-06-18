part of 'nombre_lengua_maneja_cubit.dart';

abstract class NombresLenguasManejaState extends Equatable {
  final List<NombreLenguaManejaEntity>? nombresLenguasManeja;
  const NombresLenguasManejaState({this.nombresLenguasManeja});

  @override
  List<Object> get props => [];
}

class NombresLenguasManejaInitial extends NombresLenguasManejaState {}

class NombresLenguasManejaLoading extends NombresLenguasManejaState {}

class NombresLenguasManejaLoaded extends NombresLenguasManejaState {
  final List<NombreLenguaManejaEntity>? nombresLenguasManejaLoaded;

  const NombresLenguasManejaLoaded(this.nombresLenguasManejaLoaded)
      : super(nombresLenguasManeja: nombresLenguasManejaLoaded);
}

class NombresLenguasManejaError extends NombresLenguasManejaState {
  final String message;

  const NombresLenguasManejaError(this.message);
}
