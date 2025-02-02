part of 'tipo_documento_cubit.dart';

abstract class TiposDocumentoState extends Equatable {
  final List<TipoDocumentoEntity>? tiposDocumento;
  const TiposDocumentoState({this.tiposDocumento});

  @override
  List<Object> get props => [];
}

class TiposDocumentoInitial extends TiposDocumentoState {}

class TiposDocumentoLoading extends TiposDocumentoState {}

class TiposDocumentoLoaded extends TiposDocumentoState {
  final List<TipoDocumentoEntity>? tiposDocumentoLoaded;

  const TiposDocumentoLoaded(this.tiposDocumentoLoaded)
      : super(tiposDocumento: tiposDocumentoLoaded);
}

class TiposDocumentoError extends TiposDocumentoState {
  final String message;

  const TiposDocumentoError(this.message);
}
