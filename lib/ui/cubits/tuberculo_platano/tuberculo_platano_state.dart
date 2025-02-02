part of 'tuberculo_platano_cubit.dart';

abstract class TuberculosPlatanosState extends Equatable {
  final List<TuberculoPlatanoEntity>? tuberculosPlatanos;
  const TuberculosPlatanosState({this.tuberculosPlatanos});

  @override
  List<Object> get props => [];
}

class TuberculosPlatanosInitial extends TuberculosPlatanosState {}

class TuberculosPlatanosLoading extends TuberculosPlatanosState {}

class TuberculosPlatanosLoaded extends TuberculosPlatanosState {
  final List<TuberculoPlatanoEntity>? tuberculosPlatanosLoaded;

  const TuberculosPlatanosLoaded(this.tuberculosPlatanosLoaded)
      : super(tuberculosPlatanos: tuberculosPlatanosLoaded);
}

class TuberculosPlatanosError extends TuberculosPlatanosState {
  final String message;

  const TuberculosPlatanosError(this.message);
}
