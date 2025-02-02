part of 'parentesco_cubit.dart';

abstract class ParentescosState extends Equatable {
  final List<ParentescoEntity>? parentescos;
  const ParentescosState({this.parentescos});

  @override
  List<Object> get props => [];
}

class ParentescosInitial extends ParentescosState {}

class ParentescosLoading extends ParentescosState {}

class ParentescosLoaded extends ParentescosState {
  final List<ParentescoEntity>? parentescosLoaded;

  const ParentescosLoaded(this.parentescosLoaded)
      : super(parentescos: parentescosLoaded);
}

class ParentescosError extends ParentescosState {
  final String message;

  const ParentescosError(this.message);
}
