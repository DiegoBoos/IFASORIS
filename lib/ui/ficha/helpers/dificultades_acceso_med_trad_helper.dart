import 'package:flutter/material.dart';

import '../../../data/models/dificultad_acceso_med_tradicional_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleDificultadAccesoMedTradSelection(
    FormFieldState<List<LstDificultadAccesoMedTradicional>> formState,
    int? optionId,
    BuildContext context,
    bool? value,
    int dificultadAccesoMedTradId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems =
      List<LstDificultadAccesoMedTradicional>.from(formState.value ?? []);

  if (optionId != null) {
    _handleOptionIdSelection(context, value, isMaxSelectionReached,
        selectedItems, dificultadAccesoMedTradId, optionId);
  } else {
    _handleRegularSelection(context, value, isMaxSelectionReached,
        selectedItems, dificultadAccesoMedTradId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(DificultadesAccesoMedTradicionalChanged(selectedItems));
}

void _handleOptionIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstDificultadAccesoMedTradicional> selectedItems,
    int dificultadAccesoMedTradId,
    int optionId) {
  if (isMaxSelectionReached && dificultadAccesoMedTradId != optionId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithOptionId(
        value, selectedItems, dificultadAccesoMedTradId, optionId);
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

void _updateSelectedItemsWithOptionId(
    bool value,
    List<LstDificultadAccesoMedTradicional> selectedItems,
    int dificultadAccesoMedTradId,
    int optionId) {
  if (dificultadAccesoMedTradId == optionId) {
    selectedItems.clear();
    selectedItems.add(
        LstDificultadAccesoMedTradicional(dificultadAccesoMedTradId: optionId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.dificultadAccesoMedTradId == optionId);
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
