import 'package:equatable/equatable.dart';

class LenguaManejaEntity extends Equatable {
  final int? lenguaManejaId;
  final String? descripcion;

  const LenguaManejaEntity({
    this.lenguaManejaId,
    this.descripcion,
  });

  @override
  List<Object?> get props => [
        lenguaManejaId,
        descripcion,
      ];
}
