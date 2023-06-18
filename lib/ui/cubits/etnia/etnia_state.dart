part of 'etnia_cubit.dart';

abstract class EtniasState extends Equatable {
  final List<EtniaEntity>? etnias;
  const EtniasState({this.etnias});

  @override
  List<Object> get props => [];
}

class EtniasInitial extends EtniasState {}

class EtniasLoading extends EtniasState {}

class EtniasLoaded extends EtniasState {
  final List<EtniaEntity>? etniasLoaded;

  const EtniasLoaded(this.etniasLoaded) : super(etnias: etniasLoaded);
}

class EtniasError extends EtniasState {
  final String message;

  const EtniasError(this.message);
}
