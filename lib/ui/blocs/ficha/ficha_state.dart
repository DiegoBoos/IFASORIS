part of 'ficha_bloc.dart';

abstract class FichaState extends Equatable {
  final FichaEntity? ficha;

  const FichaState({this.ficha});

  @override
  List<Object?> get props => [ficha];
}

class FichaInitial extends FichaState {}

class FichaLoading extends FichaState {}

class FichaCreated extends FichaState {
  final FichaEntity? fichaCreated;

  const FichaCreated(this.fichaCreated)
      : super(
          ficha: fichaCreated,
        );

  @override
  List<Object?> get props => [fichaCreated];
}

class FichaError extends FichaState {
  final String message;

  const FichaError(this.message);

  @override
  List<Object?> get props => [message];
}
