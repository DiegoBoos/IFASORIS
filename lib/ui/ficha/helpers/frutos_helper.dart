import 'package:flutter/material.dart';

import '../../../data/models/fruto_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleFrutoSelection(
    FormFieldState<List<LstFruto>> formState,
    int? optionId,
    BuildContext context,
    bool? value,
    int frutoId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 5;

  var selectedItems = List<LstFruto>.from(formState.value ?? []);

  if (optionId != null) {
    _handleOptionIdSelection(context, value, isMaxSelectionReached,
        selectedItems, frutoId, optionId);
  } else {
    _handleRegularSelection(
        context, value, isMaxSelectionReached, selectedItems, frutoId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(FrutosChanged(selectedItems));
}

void _handleOptionIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstFruto> selectedItems,
    int frutoId,
    int optionId) {
  if (isMaxSelectionReached && frutoId != optionId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithOptionId(value, selectedItems, frutoId, optionId);
  }
}

void _handleRegularSelection(BuildContext context, bool value,
    bool isMaxSelectionReached, List<LstFruto> selectedItems, int frutoId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, frutoId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo cinco opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsWithOptionId(
    bool value, List<LstFruto> selectedItems, int frutoId, int optionId) {
  if (frutoId == optionId) {
    selectedItems.clear();
    selectedItems.add(LstFruto(frutoId: optionId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.frutoId == optionId);
    selectedItems.add(LstFruto(frutoId: frutoId));
  } else {
    selectedItems.removeWhere((e) => e.frutoId == frutoId);
  }
}

void _updateSelectedItemsRegular(
    bool value, List<LstFruto> selectedItems, int frutoId) {
  if (value) {
    selectedItems.add(LstFruto(frutoId: frutoId));
  } else {
    selectedItems.removeWhere((e) => e.frutoId == frutoId);
  }
}
