part of 'fruto_cubit.dart';

abstract class FrutosState extends Equatable {
  final List<FrutoEntity>? frutos;
  const FrutosState({this.frutos});

  @override
  List<Object> get props => [];
}

class FrutosInitial extends FrutosState {}

class FrutosLoading extends FrutosState {}

class FrutosLoaded extends FrutosState {
  final List<FrutoEntity>? frutosLoaded;

  const FrutosLoaded(this.frutosLoaded) : super(frutos: frutosLoaded);
}

class FrutosError extends FrutosState {
  final String message;

  const FrutosError(this.message);
}
