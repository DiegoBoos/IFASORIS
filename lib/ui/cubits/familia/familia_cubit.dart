import 'package:equatable/equatable.dart';

import '../../../domain/entities/familia_entity.dart';

abstract class FamiliaState extends Equatable {
  final FamiliaEntity familia;
  const FamiliaState({required this.familia});

  @override
  List<Object?> get props => [];
}

class FamiliaInitial extends FamiliaState {
  FamiliaInitial() : super(familia: initObject());
}

class FamiliaLoading extends FamiliaState {
  const FamiliaLoading({required super.familia});
}

class FamiliaLoaded extends FamiliaState {
  final FamiliaEntity familiaLoaded;

  const FamiliaLoaded(this.familiaLoaded) : super(familia: familiaLoaded);
}

class FamiliaChanged extends FamiliaState {
  final FamiliaEntity familiaChanged;

  const FamiliaChanged(this.familiaChanged) : super(familia: familiaChanged);
}

class FamiliaSaved extends FamiliaState {
  const FamiliaSaved({required super.familia});
}

class FamiliaError extends FamiliaState {
  final String message;

  FamiliaError(this.message) : super(familia: initObject());

  @override
  List<Object?> get props => [message];
}

FamiliaEntity initObject() {
  return FamiliaEntity(
    fichaId: 0,
    apellidosFlia: '',
    afiliadoId: 0,
  );
}
