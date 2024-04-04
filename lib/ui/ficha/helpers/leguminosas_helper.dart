import 'package:flutter/material.dart';

import '../../../data/models/leguminosa_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleLeguminosaSelection(
    FormFieldState<List<LstLeguminosa>> formState,
    int? ningunoId,
    BuildContext context,
    bool? value,
    int leguminosaId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 5;

  var selectedItems = List<LstLeguminosa>.from(formState.value ?? []);

  if (ningunoId != null) {
    _handleNingunoIdSelection(context, value, isMaxSelectionReached,
        selectedItems, leguminosaId, ningunoId);
  } else {
    _handleRegularSelection(
        context, value, isMaxSelectionReached, selectedItems, leguminosaId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(LeguminosasChanged(selectedItems));
}

void _handleNingunoIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstLeguminosa> selectedItems,
    int leguminosaId,
    int ningunoId) {
  if (isMaxSelectionReached && leguminosaId != ningunoId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithNingunoId(
        value, selectedItems, leguminosaId, ningunoId);
  }
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstLeguminosa> selectedItems,
    int leguminosaId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, leguminosaId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo cinco opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsWithNingunoId(bool value,
    List<LstLeguminosa> selectedItems, int leguminosaId, int ningunoId) {
  if (leguminosaId == ningunoId) {
    selectedItems.clear();
    selectedItems.add(LstLeguminosa(leguminosaId: ningunoId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.leguminosaId == ningunoId);
    selectedItems.add(LstLeguminosa(leguminosaId: leguminosaId));
  } else {
    selectedItems.removeWhere((e) => e.leguminosaId == leguminosaId);
  }
}

void _updateSelectedItemsRegular(
    bool value, List<LstLeguminosa> selectedItems, int leguminosaId) {
  if (value) {
    selectedItems.add(LstLeguminosa(leguminosaId: leguminosaId));
  } else {
    selectedItems.removeWhere((e) => e.leguminosaId == leguminosaId);
  }
}
