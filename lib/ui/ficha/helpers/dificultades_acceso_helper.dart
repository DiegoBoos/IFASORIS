import 'package:flutter/material.dart';

import '../../../data/models/dificultad_acceso_ca_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleDificultadAccesoSelection(
    FormFieldState<List<LstDificultadAccesoAtencion>> formState,
    int? ningunoId,
    BuildContext context,
    bool? value,
    int dificultaAccesoId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems =
      List<LstDificultadAccesoAtencion>.from(formState.value ?? []);

  if (ningunoId != null) {
    _handleNingunoIdSelection(context, value, isMaxSelectionReached,
        selectedItems, dificultaAccesoId, ningunoId);
  } else {
    _handleRegularSelection(context, value, isMaxSelectionReached,
        selectedItems, dificultaAccesoId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(DificultadesAccesoCAChanged(selectedItems));
}

void _handleNingunoIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstDificultadAccesoAtencion> selectedItems,
    int dificultaAccesoId,
    int ningunoId) {
  if (isMaxSelectionReached && dificultaAccesoId != ningunoId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithNingunoId(
        value, selectedItems, dificultaAccesoId, ningunoId);
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

void _updateSelectedItemsWithNingunoId(
    bool value,
    List<LstDificultadAccesoAtencion> selectedItems,
    int dificultaAccesoId,
    int ningunoId) {
  if (dificultaAccesoId == ningunoId) {
    selectedItems.clear();
    selectedItems
        .add(LstDificultadAccesoAtencion(dificultaAccesoId: ningunoId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.dificultaAccesoId == ningunoId);
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
