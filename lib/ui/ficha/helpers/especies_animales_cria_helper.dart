import 'package:flutter/material.dart';

import '../../../data/models/especie_animal.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleEspecieAnimalCriaSelection(
    FormFieldState<List<LstAnimalCria>> formState,
    int? ningunoId,
    BuildContext context,
    bool? value,
    int especieAnimalCriaId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 5;

  var selectedItems = List<LstAnimalCria>.from(formState.value ?? []);

  if (ningunoId != null) {
    _handleNingunoIdSelection(context, value, isMaxSelectionReached,
        selectedItems, especieAnimalCriaId, ningunoId);
  } else {
    _handleRegularSelection(context, value, isMaxSelectionReached,
        selectedItems, especieAnimalCriaId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(EspeciesAnimalesCriaChanged(selectedItems));
}

void _handleNingunoIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstAnimalCria> selectedItems,
    int especieAnimalCriaId,
    int ningunoId) {
  if (isMaxSelectionReached && especieAnimalCriaId != ningunoId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithNingunoId(
        value, selectedItems, especieAnimalCriaId, ningunoId);
  }
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstAnimalCria> selectedItems,
    int especieAnimalCriaId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, especieAnimalCriaId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomSnackBar.showCustomDialog(context, 'Error', 'Máximo cinco opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsWithNingunoId(bool value,
    List<LstAnimalCria> selectedItems, int especieAnimalCriaId, int ningunoId) {
  if (especieAnimalCriaId == ningunoId) {
    selectedItems.clear();
    selectedItems.add(LstAnimalCria(especieAnimalCriaId: ningunoId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.especieAnimalCriaId == ningunoId);
    selectedItems.add(LstAnimalCria(especieAnimalCriaId: especieAnimalCriaId));
  } else {
    selectedItems
        .removeWhere((e) => e.especieAnimalCriaId == especieAnimalCriaId);
  }
}

void _updateSelectedItemsRegular(
    bool value, List<LstAnimalCria> selectedItems, int especieAnimalCriaId) {
  if (value) {
    selectedItems.add(LstAnimalCria(especieAnimalCriaId: especieAnimalCriaId));
  } else {
    selectedItems
        .removeWhere((e) => e.especieAnimalCriaId == especieAnimalCriaId);
  }
}
