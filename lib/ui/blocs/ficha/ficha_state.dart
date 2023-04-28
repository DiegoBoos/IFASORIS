part of 'ficha_bloc.dart';

abstract class FichasState extends Equatable {
  final List<FichaEntity>? fichas;

  const FichasState({this.fichas});

  @override
  List<Object?> get props => [fichas];
}

class FichasInitial extends FichasState {}

class FichasLoading extends FichasState {}

class FichasLoaded extends FichasState {
  final List<FichaEntity>? fichasLoaded;

  const FichasLoaded(this.fichasLoaded)
      : super(
          fichas: fichasLoaded,
        );

  @override
  List<Object?> get props => [fichasLoaded];
}

class FichasError extends FichasState {
  final String message;

  const FichasError(this.message);

  @override
  List<Object?> get props => [message];
}
