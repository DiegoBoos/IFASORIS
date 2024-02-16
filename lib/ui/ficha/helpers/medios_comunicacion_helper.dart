import 'package:flutter/material.dart';

import '../../../data/models/medio_comunicacion_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleMediosComunicacionSelection(
    FormFieldState<List<LstMediosComunica>> formState,
    int? ningunaId,
    BuildContext context,
    bool? value,
    int medioComunicacionId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems = List<LstMediosComunica>.from(formState.value ?? []);

  if (ningunaId != null) {
    _handleNingunaIdSelection(context, value, isMaxSelectionReached,
        selectedItems, medioComunicacionId, ningunaId);
  } else {
    _handleRegularSelection(context, value, isMaxSelectionReached,
        selectedItems, medioComunicacionId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(MediosComunicacionChanged(selectedItems));
}

void _handleNingunaIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstMediosComunica> selectedItems,
    int medioComunicacionId,
    int ningunaId) {
  if (isMaxSelectionReached && medioComunicacionId != ningunaId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithNingunaId(
        value, selectedItems, medioComunicacionId, ningunaId);
  }
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstMediosComunica> selectedItems,
    int medioComunicacionId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, medioComunicacionId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo tres opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsWithNingunaId(
    bool value,
    List<LstMediosComunica> selectedItems,
    int medioComunicacionId,
    int ningunaId) {
  if (medioComunicacionId == ningunaId) {
    selectedItems.clear();
    selectedItems.add(LstMediosComunica(medioComunicacionId: ningunaId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.medioComunicacionId == ningunaId);
    selectedItems
        .add(LstMediosComunica(medioComunicacionId: medioComunicacionId));
  } else {
    selectedItems
        .removeWhere((e) => e.medioComunicacionId == medioComunicacionId);
  }
}

void _updateSelectedItemsRegular(bool value,
    List<LstMediosComunica> selectedItems, int medioComunicacionId) {
  if (value) {
    selectedItems
        .add(LstMediosComunica(medioComunicacionId: medioComunicacionId));
  } else {
    selectedItems
        .removeWhere((e) => e.medioComunicacionId == medioComunicacionId);
  }
}
