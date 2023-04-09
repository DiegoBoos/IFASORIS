part of 'afiliado_bloc.dart';

abstract class AfiliadosEvent extends Equatable {
  const AfiliadosEvent();

  @override
  List<Object> get props => [];
}

class GetAfiliadosByDepartamento extends AfiliadosEvent {
  final int dtoId;
  final int pagina;
  final int registrosPorPagina;

  const GetAfiliadosByDepartamento(
      this.dtoId, this.pagina, this.registrosPorPagina);
}
