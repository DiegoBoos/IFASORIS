import 'package:flutter/material.dart';

import '../../../data/models/especialidad_med_tradicional.dart';
import '../../blocs/atencion_salud/atencion_salud_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleEspecialidadMedTradSelection(
    FormFieldState<List<LstEspMedTradicional>> formState,
    BuildContext context,
    bool? value,
    int especialidadMedTradId,
    AtencionSaludBloc atencionSaludBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems = List<LstEspMedTradicional>.from(formState.value ?? []);

  _handleRegularSelection(context, value, isMaxSelectionReached, selectedItems,
      especialidadMedTradId);

  formState.didChange(selectedItems);
  atencionSaludBloc.add(EspecialidadesMedTradicionalChanged(selectedItems));
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstEspMedTradicional> selectedItems,
    int especialidadMedTradId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, especialidadMedTradId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo tres opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsRegular(bool value,
    List<LstEspMedTradicional> selectedItems, int especialidadMedTradId) {
  if (value) {
    selectedItems.add(
        LstEspMedTradicional(especialidadMedTradId: especialidadMedTradId));
  } else {
    selectedItems
        .removeWhere((e) => e.especialidadMedTradId == especialidadMedTradId);
  }
}
