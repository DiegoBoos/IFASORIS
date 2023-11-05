part of 'ficha_bloc.dart';

abstract class FichaEvent extends Equatable {
  const FichaEvent();

  @override
  List<Object> get props => [];
}

class LoadFichas extends FichaEvent {}

class LoadFichasDiligenciadas extends FichaEvent {
  final int familiaId;
  const LoadFichasDiligenciadas(this.familiaId);
}
