import 'package:flutter/material.dart';

import '../../../data/models/medio_utiliza_med_tradicional.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../utils/custom_alerts.dart';

void handleMedioUtilizaMedTradSelection(
    FormFieldState<List<LstMediosMedTradicional>> formState,
    BuildContext context,
    bool? value,
    int medioUtilizaMedTradId,
    DimUbicacionBloc dimUbicacionBloc) {
  bool isMaxSelectionReached =
      value! && formState.value != null && formState.value!.length >= 3;

  var selectedItems = List<LstMediosMedTradicional>.from(formState.value ?? []);

  _handleRegularSelection(context, value, isMaxSelectionReached, selectedItems,
      medioUtilizaMedTradId);

  formState.didChange(selectedItems);
  dimUbicacionBloc.add(MediosUtilizaMedTradChanged(selectedItems));
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    bool isMaxSelectionReached,
    List<LstMediosMedTradicional> selectedItems,
    int medioUtilizaMedTradId) {
  if (isMaxSelectionReached) {
    _showMaxSelectionError(context);
  } else {
    _updateSelectedItemsRegular(value, selectedItems, medioUtilizaMedTradId);
  }
}

void _showMaxSelectionError(BuildContext context) {
  CustomAlerts.showCustomDialog(context, 'Error', 'Máximo tres opciones',
      () => Navigator.pop(context), false);
}

void _updateSelectedItemsRegular(bool value,
    List<LstMediosMedTradicional> selectedItems, int medioUtilizaMedTradId) {
  if (value) {
    selectedItems.add(
        LstMediosMedTradicional(medioUtilizaMedTradId: medioUtilizaMedTradId));
  } else {
    selectedItems
        .removeWhere((e) => e.medioUtilizaMedTradId == medioUtilizaMedTradId);
  }
}
