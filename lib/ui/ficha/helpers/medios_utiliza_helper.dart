import 'package:flutter/material.dart';

import '../../../data/models/medio_utiliza_ca_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleMedioUtilizaSelection(
    FormFieldState<List<LstMediosUtilizaCA>> formState,
    BuildContext context,
    bool? value,
    int medioUtilizaId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems = List<LstMediosUtilizaCA>.from(formState.value ?? []);

  _handleRegularSelection(
      context, value, isMaxSelectionReached, selectedItems, medioUtilizaId);

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(MediosUtilizaCAChanged(selectedItems));
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstMediosUtilizaCA> selectedItems,
    int medioUtilizaId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, medioUtilizaId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo tres opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsRegular(
    bool value, List<LstMediosUtilizaCA> selectedItems, int medioUtilizaId) {
  if (value) {
    selectedItems.add(LstMediosUtilizaCA(medioUtilizaId: medioUtilizaId));
  } else {
    selectedItems.removeWhere((e) => e.medioUtilizaId == medioUtilizaId);
  }
}
