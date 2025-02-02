part of 'enfermedad_tradicional_cubit.dart';

abstract class EnfermedadesTradicionalesState extends Equatable {
  final List<EnfermedadTradicionalEntity>? enfermedadesTradicionales;

  const EnfermedadesTradicionalesState({this.enfermedadesTradicionales});

  @override
  List<Object> get props => [];
}

class EnfermedadesTradicionalesInitial extends EnfermedadesTradicionalesState {}

class EnfermedadesTradicionalesLoading extends EnfermedadesTradicionalesState {}

class EnfermedadesTradicionalesLoaded extends EnfermedadesTradicionalesState {
  final List<EnfermedadTradicionalEntity>? enfermedadesTradicionalesLoaded;

  const EnfermedadesTradicionalesLoaded(this.enfermedadesTradicionalesLoaded)
      : super(enfermedadesTradicionales: enfermedadesTradicionalesLoaded);
}

class EnfermedadesTradicionalesError extends EnfermedadesTradicionalesState {
  final String message;

  const EnfermedadesTradicionalesError(this.message);
}
