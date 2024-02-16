import 'package:flutter/material.dart';

import '../../../data/models/especie_animal_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleEspecieAnimalCriaSelection(
    FormFieldState<List<LstAnimalCria>> formState,
    int? ningunaId,
    BuildContext context,
    bool? value,
    int especieAnimalCriaId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 5;

  var selectedItems = List<LstAnimalCria>.from(formState.value ?? []);

  if (ningunaId != null) {
    _handleNingunaIdSelection(context, value, isMaxSelectionReached,
        selectedItems, especieAnimalCriaId, ningunaId);
  } else {
    _handleRegularSelection(context, value, isMaxSelectionReached,
        selectedItems, especieAnimalCriaId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(EspeciesAnimalesCriaChanged(selectedItems));
}

void _handleNingunaIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstAnimalCria> selectedItems,
    int especieAnimalCriaId,
    int ningunaId) {
  if (isMaxSelectionReached && especieAnimalCriaId != ningunaId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithNingunaId(
        value, selectedItems, especieAnimalCriaId, ningunaId);
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

void _updateSelectedItemsWithNingunaId(bool value,
    List<LstAnimalCria> selectedItems, int especieAnimalCriaId, int ningunaId) {
  if (especieAnimalCriaId == ningunaId) {
    selectedItems.clear();
    selectedItems.add(LstAnimalCria(especieAnimalCriaId: ningunaId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.especieAnimalCriaId == ningunaId);
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
