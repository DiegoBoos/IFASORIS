import 'package:flutter/material.dart';

import '../../../data/models/hortaliza_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleHortalizaSelection(
    FormFieldState<List<LstHortaliza>> formState,
    int? optionId,
    BuildContext context,
    bool? value,
    int hortalizaId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 5;

  var selectedItems = List<LstHortaliza>.from(formState.value ?? []);

  if (optionId != null) {
    _handleOptionIdSelection(context, value, isMaxSelectionReached,
        selectedItems, hortalizaId, optionId);
  } else {
    _handleRegularSelection(
        context, value, isMaxSelectionReached, selectedItems, hortalizaId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(HortalizasChanged(selectedItems));
}

void _handleOptionIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstHortaliza> selectedItems,
    int hortalizaId,
    int optionId) {
  if (isMaxSelectionReached && hortalizaId != optionId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithOptionId(
        value, selectedItems, hortalizaId, optionId);
  }
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstHortaliza> selectedItems,
    int hortalizaId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, hortalizaId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo cinco opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsWithOptionId(bool value,
    List<LstHortaliza> selectedItems, int hortalizaId, int optionId) {
  if (hortalizaId == optionId) {
    selectedItems.clear();
    selectedItems.add(LstHortaliza(hortalizaId: optionId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.hortalizaId == optionId);
    selectedItems.add(LstHortaliza(hortalizaId: hortalizaId));
  } else {
    selectedItems.removeWhere((e) => e.hortalizaId == hortalizaId);
  }
}

void _updateSelectedItemsRegular(
    bool value, List<LstHortaliza> selectedItems, int hortalizaId) {
  if (value) {
    selectedItems.add(LstHortaliza(hortalizaId: hortalizaId));
  } else {
    selectedItems.removeWhere((e) => e.hortalizaId == hortalizaId);
  }
}
