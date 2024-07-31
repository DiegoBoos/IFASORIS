import 'package:flutter/material.dart';

import '../../../data/models/enfermedad_tradicional.dart';
import '../../blocs/atencion_salud/atencion_salud_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleEnfermedadTradicionalSelection(
    FormFieldState<List<LstEnfermedadTradicional>> formState,
    BuildContext context,
    bool? value,
    int enfermedadTradicionalId,
    AtencionSaludBloc atencionSaludBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 5;

  var selectedItems =
      List<LstEnfermedadTradicional>.from(formState.value ?? []);

  _handleRegularSelection(context, value, isMaxSelectionReached, selectedItems,
      enfermedadTradicionalId);

  formState.didChange(selectedItems);
  atencionSaludBloc.add(EnfermedadesTradicionalesChanged(selectedItems));
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstEnfermedadTradicional> selectedItems,
    int enfermedadTradicionalId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, enfermedadTradicionalId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo cinco opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsRegular(bool value,
    List<LstEnfermedadTradicional> selectedItems, int enfermedadTradicionalId) {
  if (value) {
    selectedItems.add(LstEnfermedadTradicional(
        enfermedadTradicionalId: enfermedadTradicionalId));
  } else {
    selectedItems.removeWhere(
        (e) => e.enfermedadTradicionalId == enfermedadTradicionalId);
  }
}
