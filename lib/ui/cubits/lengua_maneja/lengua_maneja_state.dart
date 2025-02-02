part of 'lengua_maneja_cubit.dart';

abstract class LenguasManejaState extends Equatable {
  final List<LenguaManejaEntity>? lenguasManeja;
  const LenguasManejaState({this.lenguasManeja});

  @override
  List<Object> get props => [];
}

class LenguasManejaInitial extends LenguasManejaState {}

class LenguasManejaLoading extends LenguasManejaState {}

class LenguasManejaLoaded extends LenguasManejaState {
  final List<LenguaManejaEntity>? lenguasManejaLoaded;

  const LenguasManejaLoaded(this.lenguasManejaLoaded)
      : super(lenguasManeja: lenguasManejaLoaded);
}

class LenguasManejaError extends LenguasManejaState {
  final String message;

  const LenguasManejaError(this.message);
}
