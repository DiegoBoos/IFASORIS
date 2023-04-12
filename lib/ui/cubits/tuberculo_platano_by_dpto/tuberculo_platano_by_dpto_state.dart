part of 'tuberculo_platano_by_dpto_cubit.dart';

abstract class TuberculosPlatanosByDptoState extends Equatable {
  final List<TuberculoPlatanoEntity>? tuberculosplatanosByDpto;
  const TuberculosPlatanosByDptoState({this.tuberculosplatanosByDpto});

  @override
  List<Object> get props => [];
}

class TuberculosPlatanosByDptoInitial extends TuberculosPlatanosByDptoState {}

class TuberculosPlatanosByDptoLoading extends TuberculosPlatanosByDptoState {}

class TuberculosPlatanosByDptoLoaded extends TuberculosPlatanosByDptoState {
  final List<TuberculoPlatanoEntity>? tuberculosplatanosByDptoLoaded;

  const TuberculosPlatanosByDptoLoaded(this.tuberculosplatanosByDptoLoaded)
      : super(tuberculosplatanosByDpto: tuberculosplatanosByDptoLoaded);
}

class TuberculosPlatanosByDptoError extends TuberculosPlatanosByDptoState {
  final String message;

  const TuberculosPlatanosByDptoError(this.message);
}
