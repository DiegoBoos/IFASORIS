import 'package:flutter/material.dart';

import '../../../data/models/cereal_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleCerealSelection(
    FormFieldState<List<LstCereal>> formState,
    int? ningunaId,
    BuildContext context,
    bool? value,
    int cerealId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems = List<LstCereal>.from(formState.value ?? []);

  if (ningunaId != null) {
    _handleNingunaIdSelection(context, value, isMaxSelectionReached,
        selectedItems, cerealId, ningunaId);
  } else {
    _handleRegularSelection(
        context, value, isMaxSelectionReached, selectedItems, cerealId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(CerealesChanged(selectedItems));
}

void _handleNingunaIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstCereal> selectedItems,
    int cerealId,
    int ningunaId) {
  if (isMaxSelectionReached && cerealId != ningunaId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithNingunaId(
        value, selectedItems, cerealId, ningunaId);
  }
}

void _handleRegularSelection(BuildContext context, bool value,
    bool isMaxSelectionReached, List<LstCereal> selectedItems, int cerealId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, cerealId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo tres opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsWithNingunaId(
    bool value, List<LstCereal> selectedItems, int cerealId, int ningunaId) {
  if (cerealId == ningunaId) {
    selectedItems.clear();
    selectedItems.add(LstCereal(cerealId: ningunaId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.cerealId == ningunaId);
    selectedItems.add(LstCereal(cerealId: cerealId));
  } else {
    selectedItems.removeWhere((e) => e.cerealId == cerealId);
  }
}

void _updateSelectedItemsRegular(
    bool value, List<LstCereal> selectedItems, int cerealId) {
  if (value) {
    selectedItems.add(LstCereal(cerealId: cerealId));
  } else {
    selectedItems.removeWhere((e) => e.cerealId == cerealId);
  }
}
