part of 'familia_bloc.dart';

abstract class FamiliaEvent extends Equatable {
  const FamiliaEvent();

  @override
  List<Object> get props => [];
}

class LoadFamilias extends FamiliaEvent {}
