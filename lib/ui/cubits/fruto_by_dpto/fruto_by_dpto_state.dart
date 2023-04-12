part of 'fruto_by_dpto_cubit.dart';

abstract class FrutosByDptoState extends Equatable {
  final List<FrutoEntity>? frutosByDpto;
  const FrutosByDptoState({this.frutosByDpto});

  @override
  List<Object> get props => [];
}

class FrutosByDptoInitial extends FrutosByDptoState {}

class FrutosByDptoLoading extends FrutosByDptoState {}

class FrutosByDptoLoaded extends FrutosByDptoState {
  final List<FrutoEntity>? frutosByDptoLoaded;

  const FrutosByDptoLoaded(this.frutosByDptoLoaded)
      : super(frutosByDpto: frutosByDptoLoaded);
}

class FrutosByDptoError extends FrutosByDptoState {
  final String message;

  const FrutosByDptoError(this.message);
}
