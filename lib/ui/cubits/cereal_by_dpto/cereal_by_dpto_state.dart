part of 'cereal_by_dpto_cubit.dart';

abstract class CerealesByDptoState extends Equatable {
  final List<CerealEntity>? cerealesByDpto;
  const CerealesByDptoState({this.cerealesByDpto});

  @override
  List<Object> get props => [];
}

class CerealesByDptoInitial extends CerealesByDptoState {}

class CerealesByDptoLoading extends CerealesByDptoState {}

class CerealesByDptoLoaded extends CerealesByDptoState {
  final List<CerealEntity>? cerealesByDptoLoaded;

  const CerealesByDptoLoaded(this.cerealesByDptoLoaded)
      : super(cerealesByDpto: cerealesByDptoLoaded);
}

class CerealesByDptoError extends CerealesByDptoState {
  final String message;

  const CerealesByDptoError(this.message);
}
