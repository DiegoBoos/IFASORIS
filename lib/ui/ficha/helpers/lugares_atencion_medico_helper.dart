import 'package:flutter/material.dart';

import '../../../data/models/lugar_atencion_medico_model.dart';
import '../../blocs/atencion_salud/atencion_salud_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleLugarAtencionMedicoSelection(
    FormFieldState<List<LstLugarAtencionMedico>> formState,
    BuildContext context,
    bool? value,
    int lugarAtencionMedicoId,
    AtencionSaludBloc atencionSaludBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems = List<LstLugarAtencionMedico>.from(formState.value ?? []);

  _handleRegularSelection(context, value, isMaxSelectionReached, selectedItems,
      lugarAtencionMedicoId);

  formState.didChange(selectedItems);
  atencionSaludBloc.add(LugaresAtencionMedicoChanged(selectedItems));
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstLugarAtencionMedico> selectedItems,
    int lugarAtencionMedicoId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, lugarAtencionMedicoId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo tres opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsRegular(bool value,
    List<LstLugarAtencionMedico> selectedItems, int lugarAtencionMedicoId) {
  if (value) {
    selectedItems.add(
        LstLugarAtencionMedico(lugarAtencionMedicoId: lugarAtencionMedicoId));
  } else {
    selectedItems
        .removeWhere((e) => e.lugarAtencionMedicoId == lugarAtencionMedicoId);
  }
}
