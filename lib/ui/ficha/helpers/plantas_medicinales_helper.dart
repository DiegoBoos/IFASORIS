import 'package:flutter/material.dart';
import '../../../data/models/planta_medicinal.dart';
import '../../blocs/atencion_salud/atencion_salud_bloc.dart';
import '../../utils/custom_alerts.dart';

void handlePlantaMedicinalSelection(
    FormFieldState<List<LstPlantaMedicinal>> formState,
    BuildContext context,
    bool? value,
    int plantaMedicinalId,
    AtencionSaludBloc atencionSaludBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 5;

  var selectedItems = List<LstPlantaMedicinal>.from(formState.value ?? []);

  _handleRegularSelection(
      context, value, isMaxSelectionReached, selectedItems, plantaMedicinalId);

  formState.didChange(selectedItems);
  atencionSaludBloc.add(PlantasMedicinalesChanged(selectedItems));
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstPlantaMedicinal> selectedItems,
    int plantaMedicinalId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, plantaMedicinalId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomAlerts.showCustomDialog(context, 'Error', 'Máximo cinco opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsRegular(
    bool value, List<LstPlantaMedicinal> selectedItems, int plantaMedicinalId) {
  if (value) {
    selectedItems.add(LstPlantaMedicinal(plantaMedicinalId: plantaMedicinalId));
  } else {
    selectedItems.removeWhere((e) => e.plantaMedicinalId == plantaMedicinalId);
  }
}
