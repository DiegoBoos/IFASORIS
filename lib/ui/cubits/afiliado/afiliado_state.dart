part of 'afiliado_cubit.dart';

abstract class AfiliadoState extends Equatable {
  final AfiliadoEntity? afiliado;
  final FichaEntity? ficha;

  const AfiliadoState({this.afiliado, this.ficha});

  @override
  List<Object?> get props => [afiliado, ficha];
}

class AfiliadoInitial extends AfiliadoState {}

class AfiliadoLoaded extends AfiliadoState {
  final AfiliadoEntity afiliadoLoaded;
  final FichaEntity? fichaLoaded;

  const AfiliadoLoaded(this.afiliadoLoaded, {this.fichaLoaded})
      : super(afiliado: afiliadoLoaded, ficha: fichaLoaded);

  @override
  List<Object?> get props => [afiliadoLoaded, ficha];
}

class AfiliadoFichaReportada extends AfiliadoState {
  final String message;

  const AfiliadoFichaReportada(this.message);

  @override
  List<Object> get props => [message];
}

class AfiliadoError extends AfiliadoState {
  final String message;

  const AfiliadoError(this.message);

  @override
  List<Object> get props => [message];
}
