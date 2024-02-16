import 'package:flutter/material.dart';

import '../../../data/models/dificultad_acceso_med_tradicional_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleDificultadAccesoMedTradSelection(
    FormFieldState<List<LstDificultadAccesoMedTradicional>> formState,
    int? ningunaId,
    BuildContext context,
    bool? value,
    int dificultadAccesoMedTradId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems =
      List<LstDificultadAccesoMedTradicional>.from(formState.value ?? []);

  if (ningunaId != null) {
    _handleNingunaIdSelection(context, value, isMaxSelectionReached,
        selectedItems, dificultadAccesoMedTradId, ningunaId);
  } else {
    _handleRegularSelection(context, value, isMaxSelectionReached,
        selectedItems, dificultadAccesoMedTradId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(DificultadesAccesoMedTradicionalChanged(selectedItems));
}

void _handleNingunaIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstDificultadAccesoMedTradicional> selectedItems,
    int dificultadAccesoMedTradId,
    int ningunaId) {
  if (isMaxSelectionReached && dificultadAccesoMedTradId != ningunaId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithNingunaId(
        value, selectedItems, dificultadAccesoMedTradId, ningunaId);
  }
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstDificultadAccesoMedTradicional> selectedItems,
    int dificultadAccesoMedTradId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(
        value, selectedItems, dificultadAccesoMedTradId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo tres opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsWithNingunaId(
    bool value,
    List<LstDificultadAccesoMedTradicional> selectedItems,
    int dificultadAccesoMedTradId,
    int ningunaId) {
  if (dificultadAccesoMedTradId == ningunaId) {
    selectedItems.clear();
    selectedItems.add(LstDificultadAccesoMedTradicional(
        dificultadAccesoMedTradId: ningunaId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.dificultadAccesoMedTradId == ningunaId);
    selectedItems.add(LstDificultadAccesoMedTradicional(
        dificultadAccesoMedTradId: dificultadAccesoMedTradId));
  } else {
    selectedItems.removeWhere(
        (e) => e.dificultadAccesoMedTradId == dificultadAccesoMedTradId);
  }
}

void _updateSelectedItemsRegular(
    bool value,
    List<LstDificultadAccesoMedTradicional> selectedItems,
    int dificultadAccesoMedTradId) {
  if (value) {
    selectedItems.add(LstDificultadAccesoMedTradicional(
        dificultadAccesoMedTradId: dificultadAccesoMedTradId));
  } else {
    selectedItems.removeWhere(
        (e) => e.dificultadAccesoMedTradId == dificultadAccesoMedTradId);
  }
}
