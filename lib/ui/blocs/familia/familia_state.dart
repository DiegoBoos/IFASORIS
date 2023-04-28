part of 'familia_bloc.dart';

abstract class FamiliasState extends Equatable {
  final List<FamiliaEntity>? familias;

  const FamiliasState({this.familias});

  @override
  List<Object?> get props => [familias];
}

class FamiliasInitial extends FamiliasState {}

class FamiliasLoading extends FamiliasState {}

class FamiliasLoaded extends FamiliasState {
  final List<FamiliaEntity>? familiasLoaded;

  const FamiliasLoaded(this.familiasLoaded)
      : super(
          familias: familiasLoaded,
        );

  @override
  List<Object?> get props => [familiasLoaded];
}

class FamiliasError extends FamiliasState {
  final String message;

  const FamiliasError(this.message);

  @override
  List<Object?> get props => [message];
}
