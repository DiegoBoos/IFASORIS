import 'package:flutter/material.dart';
import '../../../data/models/servicio_solicitado_model.dart';
import '../../blocs/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleServicioSolicitadoSelection(
    FormFieldState<List<LstServicioSolicitado>> formState,
    BuildContext context,
    bool? value,
    int servicioSolicitadoId,
    CuidadoSaludCondRiesgoBloc cuidadoSaludCondRiesgoBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems = List<LstServicioSolicitado>.from(formState.value ?? []);

  _handleRegularSelection(context, value, isMaxSelectionReached, selectedItems,
      servicioSolicitadoId);

  formState.didChange(selectedItems);
  cuidadoSaludCondRiesgoBloc.add(ServiciosSolicitadosChanged(selectedItems));
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstServicioSolicitado> selectedItems,
    int servicioSolicitadoId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, servicioSolicitadoId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo tres opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsRegular(bool value,
    List<LstServicioSolicitado> selectedItems, int servicioSolicitadoId) {
  if (value) {
    selectedItems
        .add(LstServicioSolicitado(servicioSolicitadoId: servicioSolicitadoId));
  } else {
    selectedItems
        .removeWhere((e) => e.servicioSolicitadoId == servicioSolicitadoId);
  }
}
