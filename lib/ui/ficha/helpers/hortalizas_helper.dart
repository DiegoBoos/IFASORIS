import 'package:flutter/material.dart';

import '../../../data/models/hortaliza_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleHortalizaSelection(
    FormFieldState<List<LstHortaliza>> formState,
    int? ningunaId,
    BuildContext context,
    bool? value,
    int hortalizaId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 5;

  var selectedItems = List<LstHortaliza>.from(formState.value ?? []);

  if (ningunaId != null) {
    _handleNingunaIdSelection(context, value, isMaxSelectionReached,
        selectedItems, hortalizaId, ningunaId);
  } else {
    _handleRegularSelection(
        context, value, isMaxSelectionReached, selectedItems, hortalizaId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(HortalizasChanged(selectedItems));
}

void _handleNingunaIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstHortaliza> selectedItems,
    int hortalizaId,
    int ningunaId) {
  if (isMaxSelectionReached && hortalizaId != ningunaId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithNingunaId(
        value, selectedItems, hortalizaId, ningunaId);
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

void _updateSelectedItemsWithNingunaId(bool value,
    List<LstHortaliza> selectedItems, int hortalizaId, int ningunaId) {
  if (hortalizaId == ningunaId) {
    selectedItems.clear();
    selectedItems.add(LstHortaliza(hortalizaId: ningunaId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.hortalizaId == ningunaId);
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
