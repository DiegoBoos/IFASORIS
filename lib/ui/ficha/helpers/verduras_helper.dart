import 'package:flutter/material.dart';

import '../../../data/models/verdura_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleVerduraSelection(
    FormFieldState<List<LstVerdura>> formState,
    int? ningunaId,
    BuildContext context,
    bool? value,
    int verduraId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems = List<LstVerdura>.from(formState.value ?? []);

  if (ningunaId != null) {
    _handleNingunaIdSelection(context, value, isMaxSelectionReached,
        selectedItems, verduraId, ningunaId);
  } else {
    _handleRegularSelection(
        context, value, isMaxSelectionReached, selectedItems, verduraId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(VerdurasChanged(selectedItems));
}

void _handleNingunaIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstVerdura> selectedItems,
    int verduraId,
    int ningunaId) {
  if (isMaxSelectionReached && verduraId != ningunaId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithNingunaId(
        value, selectedItems, verduraId, ningunaId);
  }
}

void _handleRegularSelection(BuildContext context, bool value,
    bool isMaxSelectionReached, List<LstVerdura> selectedItems, int verduraId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, verduraId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo tres opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsWithNingunaId(
    bool value, List<LstVerdura> selectedItems, int verduraId, int ningunaId) {
  if (verduraId == ningunaId) {
    selectedItems.clear();
    selectedItems.add(LstVerdura(verduraId: ningunaId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.verduraId == ningunaId);
    selectedItems.add(LstVerdura(verduraId: verduraId));
  } else {
    selectedItems.removeWhere((e) => e.verduraId == verduraId);
  }
}

void _updateSelectedItemsRegular(
    bool value, List<LstVerdura> selectedItems, int verduraId) {
  if (value) {
    selectedItems.add(LstVerdura(verduraId: verduraId));
  } else {
    selectedItems.removeWhere((e) => e.verduraId == verduraId);
  }
}
