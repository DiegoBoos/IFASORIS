part of 'curso_vida_cubit.dart';

abstract class CursosVidaState extends Equatable {
  final List<CursoVidaEntity>? cursosVida;
  const CursosVidaState({this.cursosVida});

  @override
  List<Object> get props => [];
}

class CursosVidaInitial extends CursosVidaState {}

class CursosVidaLoading extends CursosVidaState {}

class CursosVidaLoaded extends CursosVidaState {
  final List<CursoVidaEntity>? cursosVidaLoaded;

  const CursosVidaLoaded(this.cursosVidaLoaded)
      : super(cursosVida: cursosVidaLoaded);
}

class CursosVidaError extends CursosVidaState {
  final String message;

  const CursosVidaError(this.message);
}
