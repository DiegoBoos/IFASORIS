import 'package:flutter/material.dart';
import '../../../data/models/nombre_enfermedad.dart';
import '../../blocs/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_bloc.dart';
import '../../utils/custom_alerts.dart';

void handleNombreEnfermedadSelection(
    FormFieldState<List<LstNombreEnfermedad>> formState,
    BuildContext context,
    bool? value,
    int nombreEnfermedadId,
    CuidadoSaludCondRiesgoBloc cuidadoSaludCondRiesgoBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems = List<LstNombreEnfermedad>.from(formState.value ?? []);

  _handleRegularSelection(
      context, value, isMaxSelectionReached, selectedItems, nombreEnfermedadId);

  formState.didChange(selectedItems);
  cuidadoSaludCondRiesgoBloc.add(NombresEnfermedadesChanged(selectedItems));
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstNombreEnfermedad> selectedItems,
    int nombreEnfermedadId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, nombreEnfermedadId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomAlerts.showCustomDialog(context, 'Error', 'Máximo tres opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsRegular(bool value,
    List<LstNombreEnfermedad> selectedItems, int nombreEnfermedadId) {
  if (value) {
    selectedItems
        .add(LstNombreEnfermedad(nombreEnfermedadId: nombreEnfermedadId));
  } else {
    selectedItems
        .removeWhere((e) => e.nombreEnfermedadId == nombreEnfermedadId);
  }
}
