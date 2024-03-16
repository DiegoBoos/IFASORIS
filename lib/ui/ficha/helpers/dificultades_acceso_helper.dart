import 'package:flutter/material.dart';

import '../../../data/models/dificultad_acceso_ca_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleDificultadAccesoSelection(
    FormFieldState<List<LstDificultadAccesoAtencion>> formState,
    int? optionId,
    BuildContext context,
    bool? value,
    int dificultaAccesoId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems =
      List<LstDificultadAccesoAtencion>.from(formState.value ?? []);

  if (optionId != null) {
    _handleOptionIdSelection(context, value, isMaxSelectionReached,
        selectedItems, dificultaAccesoId, optionId);
  } else {
    _handleRegularSelection(context, value, isMaxSelectionReached,
        selectedItems, dificultaAccesoId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(DificultadesAccesoCAChanged(selectedItems));
}

void _handleOptionIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstDificultadAccesoAtencion> selectedItems,
    int dificultaAccesoId,
    int optionId) {
  if (isMaxSelectionReached && dificultaAccesoId != optionId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithOptionId(
        value, selectedItems, dificultaAccesoId, optionId);
  }
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstDificultadAccesoAtencion> selectedItems,
    int dificultaAccesoId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, dificultaAccesoId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo tres opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsWithOptionId(
    bool value,
    List<LstDificultadAccesoAtencion> selectedItems,
    int dificultaAccesoId,
    int optionId) {
  if (dificultaAccesoId == optionId) {
    selectedItems.clear();
    selectedItems.add(LstDificultadAccesoAtencion(dificultaAccesoId: optionId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.dificultaAccesoId == optionId);
    selectedItems
        .add(LstDificultadAccesoAtencion(dificultaAccesoId: dificultaAccesoId));
  } else {
    selectedItems.removeWhere((e) => e.dificultaAccesoId == dificultaAccesoId);
  }
}

void _updateSelectedItemsRegular(bool value,
    List<LstDificultadAccesoAtencion> selectedItems, int dificultaAccesoId) {
  if (value) {
    selectedItems
        .add(LstDificultadAccesoAtencion(dificultaAccesoId: dificultaAccesoId));
  } else {
    selectedItems.removeWhere((e) => e.dificultaAccesoId == dificultaAccesoId);
  }
}
