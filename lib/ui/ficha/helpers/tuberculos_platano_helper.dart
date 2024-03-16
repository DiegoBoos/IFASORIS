import 'package:flutter/material.dart';

import '../../../data/models/tuberculo_platano_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleTuberculoPlatanoSelection(
    FormFieldState<List<LstTuberculo>> formState,
    int? optionId,
    BuildContext context,
    bool? value,
    int tuberculoPlatanoId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 4;

  var selectedItems = List<LstTuberculo>.from(formState.value ?? []);

  if (optionId != null) {
    _handleOptionIdSelection(context, value, isMaxSelectionReached,
        selectedItems, tuberculoPlatanoId, optionId);
  } else {
    _handleRegularSelection(context, value, isMaxSelectionReached,
        selectedItems, tuberculoPlatanoId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(TuberculosPlatanosChanged(selectedItems));
}

void _handleOptionIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstTuberculo> selectedItems,
    int tuberculoPlatanoId,
    int optionId) {
  if (isMaxSelectionReached && tuberculoPlatanoId != optionId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithOptionId(
        value, selectedItems, tuberculoPlatanoId, optionId);
  }
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstTuberculo> selectedItems,
    int tuberculoPlatanoId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, tuberculoPlatanoId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo cuatro opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsWithOptionId(bool value,
    List<LstTuberculo> selectedItems, int tuberculoPlatanoId, int optionId) {
  if (tuberculoPlatanoId == optionId) {
    selectedItems.clear();
    selectedItems.add(LstTuberculo(tuberculoPlatanoId: optionId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.tuberculoPlatanoId == optionId);
    selectedItems.add(LstTuberculo(tuberculoPlatanoId: tuberculoPlatanoId));
  } else {
    selectedItems
        .removeWhere((e) => e.tuberculoPlatanoId == tuberculoPlatanoId);
  }
}

void _updateSelectedItemsRegular(
    bool value, List<LstTuberculo> selectedItems, int tuberculoPlatanoId) {
  if (value) {
    selectedItems.add(LstTuberculo(tuberculoPlatanoId: tuberculoPlatanoId));
  } else {
    selectedItems
        .removeWhere((e) => e.tuberculoPlatanoId == tuberculoPlatanoId);
  }
}
