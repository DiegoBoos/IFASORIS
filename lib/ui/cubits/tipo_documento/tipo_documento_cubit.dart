import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tipo_documento_entity.dart';
import '../../../domain/usecases/tipo_documento/tipo_documento_db_usecase.dart';

part 'tipo_documento_state.dart';

class TipoDocumentoCubit extends Cubit<TiposDocumentoState> {
  final TipoDocumentoUsecaseDB tipoDocumentoUsecaseDB;

  TipoDocumentoCubit({required this.tipoDocumentoUsecaseDB})
      : super(TiposDocumentoInitial());

  void getTiposDocumentoDB() async {
    final result = await tipoDocumentoUsecaseDB.getTiposDocumentoUsecaseDB();
    result.fold(
        (failure) => emit(TiposDocumentoError(failure.properties.first)),
        (data) => emit(TiposDocumentoLoaded(data)));
  }
}
