part of 'consumo_alcohol_cubit.dart';

abstract class ConsumosAlcoholState extends Equatable {
  final List<ConsumoAlcoholEntity>? consumosAlcohol;
  const ConsumosAlcoholState({this.consumosAlcohol});

  @override
  List<Object> get props => [];
}

class ConsumosAlcoholInitial extends ConsumosAlcoholState {}

class ConsumosAlcoholLoading extends ConsumosAlcoholState {}

class ConsumosAlcoholLoaded extends ConsumosAlcoholState {
  final List<ConsumoAlcoholEntity>? consumosAlcoholLoaded;

  const ConsumosAlcoholLoaded(this.consumosAlcoholLoaded)
      : super(consumosAlcohol: consumosAlcoholLoaded);
}

class ConsumosAlcoholError extends ConsumosAlcoholState {
  final String message;

  const ConsumosAlcoholError(this.message);
}
