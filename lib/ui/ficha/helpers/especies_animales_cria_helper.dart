import 'package:flutter/material.dart';

import '../../../data/models/especie_animal_model.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_snack_bar.dart';

void handleEspecieAnimalCriaSelection(
    FormFieldState<List<LstAnimalCria>> formState,
    int? optionId,
    BuildContext context,
    bool? value,
    int especieAnimalCriaId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 5;

  var selectedItems = List<LstAnimalCria>.from(formState.value ?? []);

  if (optionId != null) {
    _handleOptionIdSelection(context, value, isMaxSelectionReached,
        selectedItems, especieAnimalCriaId, optionId);
  } else {
    _handleRegularSelection(context, value, isMaxSelectionReached,
        selectedItems, especieAnimalCriaId);
  }

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(EspeciesAnimalesCriaChanged(selectedItems));
}

void _handleOptionIdSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstAnimalCria> selectedItems,
    int especieAnimalCriaId,
    int optionId) {
  if (isMaxSelectionReached && especieAnimalCriaId != optionId) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsWithOptionId(
        value, selectedItems, especieAnimalCriaId, optionId);
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

void _updateSelectedItemsWithOptionId(bool value,
    List<LstAnimalCria> selectedItems, int especieAnimalCriaId, int optionId) {
  if (especieAnimalCriaId == optionId) {
    selectedItems.clear();
    selectedItems.add(LstAnimalCria(especieAnimalCriaId: optionId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.especieAnimalCriaId == optionId);
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
