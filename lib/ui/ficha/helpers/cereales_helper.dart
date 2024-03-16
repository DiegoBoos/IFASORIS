import 'package:flutter/material.dart';

import '../../../data/models/cereal_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleCerealSelection(
    FormFieldState<List<LstCereal>> formState,
    int? optionId,
    BuildContext context,
    bool? value,
    int cerealId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems = List<LstCereal>.from(formState.value ?? []);

  if (optionId != null) {
    _handleOptionIdSelection(context, value, isMaxSelectionReached,
        selectedItems, cerealId, optionId);
  } else {
    _handleRegularSelection(
        context, value, isMaxSelectionReached, selectedItems, cerealId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(CerealesChanged(selectedItems));
}

void _handleOptionIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstCereal> selectedItems,
    int cerealId,
    int optionId) {
  if (isMaxSelectionReached && cerealId != optionId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithOptionId(value, selectedItems, cerealId, optionId);
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

void _updateSelectedItemsWithOptionId(
    bool value, List<LstCereal> selectedItems, int cerealId, int optionId) {
  if (cerealId == optionId) {
    selectedItems.clear();
    selectedItems.add(LstCereal(cerealId: optionId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.cerealId == optionId);
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
