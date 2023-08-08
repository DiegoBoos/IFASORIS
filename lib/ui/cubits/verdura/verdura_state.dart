part of 'verdura_cubit.dart';

abstract class VerdurasState extends Equatable {
  final List<VerduraEntity>? verduras;
  const VerdurasState({this.verduras});

  @override
  List<Object> get props => [];
}

class VerdurasInitial extends VerdurasState {}

class VerdurasLoading extends VerdurasState {}

class VerdurasLoaded extends VerdurasState {
  final List<VerduraEntity>? verdurasLoaded;

  const VerdurasLoaded(this.verdurasLoaded) : super(verduras: verdurasLoaded);
}

class VerdurasError extends VerdurasState {
  final String message;

  const VerdurasError(this.message);
}
