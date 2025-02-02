part of 'afiliados_bloc.dart';

abstract class AfiliadosEvent extends Equatable {
  const AfiliadosEvent();

  @override
  List<Object> get props => [];
}

class QueryChanged extends AfiliadosEvent {
  final String query;

  const QueryChanged(this.query);
}

class ErrorMessage extends AfiliadosEvent {
  final String message;

  const ErrorMessage(this.message);
}
