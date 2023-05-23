part of 'tuberculo_platano_by_dpto_cubit.dart';

abstract class TuberculosPlatanosByDptoState extends Equatable {
  final List<TuberculoPlatanoEntity>? tuberculosPlatanosByDpto;
  const TuberculosPlatanosByDptoState({this.tuberculosPlatanosByDpto});

  @override
  List<Object> get props => [];
}

class TuberculosPlatanosByDptoInitial extends TuberculosPlatanosByDptoState {}

class TuberculosPlatanosByDptoLoading extends TuberculosPlatanosByDptoState {}

class TuberculosPlatanosByDptoLoaded extends TuberculosPlatanosByDptoState {
  final List<TuberculoPlatanoEntity>? tuberculosPlatanosByDptoLoaded;

  const TuberculosPlatanosByDptoLoaded(this.tuberculosPlatanosByDptoLoaded)
      : super(tuberculosPlatanosByDpto: tuberculosPlatanosByDptoLoaded);
}

class TuberculosPlatanosByDptoError extends TuberculosPlatanosByDptoState {
  final String message;

  const TuberculosPlatanosByDptoError(this.message);
}
