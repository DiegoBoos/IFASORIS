part of 'nombre_lengua_materna_cubit.dart';

abstract class NombresLenguasMaternaState extends Equatable {
  final List<NombreLenguaMaternaEntity>? nombresLenguasMaterna;
  const NombresLenguasMaternaState({this.nombresLenguasMaterna});

  @override
  List<Object> get props => [];
}

class NombresLenguasMaternaInitial extends NombresLenguasMaternaState {}

class NombresLenguasMaternaLoading extends NombresLenguasMaternaState {}

class NombresLenguasMaternaLoaded extends NombresLenguasMaternaState {
  final List<NombreLenguaMaternaEntity>? nombresLenguasMaternaLoaded;

  const NombresLenguasMaternaLoaded(this.nombresLenguasMaternaLoaded)
      : super(nombresLenguasMaterna: nombresLenguasMaternaLoaded);
}

class NombresLenguasMaternaError extends NombresLenguasMaternaState {
  final String message;

  const NombresLenguasMaternaError(this.message);
}
