part of 'cereal_cubit.dart';

abstract class CerealesState extends Equatable {
  final List<CerealEntity>? cereales;
  const CerealesState({this.cereales});

  @override
  List<Object> get props => [];
}

class CerealesInitial extends CerealesState {}

class CerealesLoading extends CerealesState {}

class CerealesLoaded extends CerealesState {
  final List<CerealEntity>? cerealesLoaded;

  const CerealesLoaded(this.cerealesLoaded) : super(cereales: cerealesLoaded);
}

class CerealesError extends CerealesState {
  final String message;

  const CerealesError(this.message);
}
