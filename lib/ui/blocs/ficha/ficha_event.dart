part of 'ficha_bloc.dart';

abstract class FichaEvent extends Equatable {
  const FichaEvent();

  @override
  List<Object> get props => [];
}

class NewFicha extends FichaEvent {
  final FichaEntity ficha;

  const NewFicha({required this.ficha});
}
