import 'package:flutter/material.dart';

import '../../../data/models/dificultad_acceso_med_tradicional.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleDificultadAccesoMedTradSelection(
    FormFieldState<List<LstDificultadAccesoMedTradicional>> formState,
    int? ningunoId,
    BuildContext context,
    bool? value,
    int dificultadAccesoMedTradId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems =
      List<LstDificultadAccesoMedTradicional>.from(formState.value ?? []);

  if (ningunoId != null) {
    _handleNingunoIdSelection(context, value, isMaxSelectionReached,
        selectedItems, dificultadAccesoMedTradId, ningunoId);
  } else {
    _handleRegularSelection(context, value, isMaxSelectionReached,
        selectedItems, dificultadAccesoMedTradId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(DificultadesAccesoMedTradicionalChanged(selectedItems));
}

void _handleNingunoIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstDificultadAccesoMedTradicional> selectedItems,
    int dificultadAccesoMedTradId,
    int ningunoId) {
  if (isMaxSelectionReached && dificultadAccesoMedTradId != ningunoId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithNingunoId(
        value, selectedItems, dificultadAccesoMedTradId, ningunoId);
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

void _updateSelectedItemsWithNingunoId(
    bool value,
    List<LstDificultadAccesoMedTradicional> selectedItems,
    int dificultadAccesoMedTradId,
    int ningunoId) {
  if (dificultadAccesoMedTradId == ningunoId) {
    selectedItems.clear();
    selectedItems.add(LstDificultadAccesoMedTradicional(
        dificultadAccesoMedTradId: ningunoId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.dificultadAccesoMedTradId == ningunoId);
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
