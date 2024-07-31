import 'package:flutter/material.dart';

import '../../../data/models/fruto.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleFrutoSelection(
    FormFieldState<List<LstFruto>> formState,
    int? ningunoId,
    BuildContext context,
    bool? value,
    int frutoId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 5;

  var selectedItems = List<LstFruto>.from(formState.value ?? []);

  if (ningunoId != null) {
    _handleNingunoIdSelection(context, value, isMaxSelectionReached,
        selectedItems, frutoId, ningunoId);
  } else {
    _handleRegularSelection(
        context, value, isMaxSelectionReached, selectedItems, frutoId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(FrutosChanged(selectedItems));
}

void _handleNingunoIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstFruto> selectedItems,
    int frutoId,
    int ningunoId) {
  if (isMaxSelectionReached && frutoId != ningunoId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithNingunoId(value, selectedItems, frutoId, ningunoId);
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

void _updateSelectedItemsWithNingunoId(
    bool value, List<LstFruto> selectedItems, int frutoId, int ningunoId) {
  if (frutoId == ningunoId) {
    selectedItems.clear();
    selectedItems.add(LstFruto(frutoId: ningunoId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.frutoId == ningunoId);
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
