import 'package:flutter/material.dart';

import '../../../data/models/evento_costumbre_participa_model.dart';
import '../../blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart';

void handleEventoCostumbreParticipaSelection(
    FormFieldState<List<LstEventoCostumbreParticipa>> formState,
    int? optionId,
    BuildContext context,
    bool? value,
    int eventoCostumbreParticipaId,
    DimensionSocioCulturalPueblosIndigenasBloc
        dimensionSocioCulturalPueblosIndigenasBloc) {
  var selectedItems =
      List<LstEventoCostumbreParticipa>.from(formState.value ?? []);

  if (optionId != null) {
    _handleOptionIdSelection(
        context, value!, selectedItems, eventoCostumbreParticipaId, optionId);
  } else {
    _handleRegularSelection(
        context, value!, selectedItems, eventoCostumbreParticipaId);
  }

  formState.didChange(selectedItems);
  dimensionSocioCulturalPueblosIndigenasBloc
      .add(EventosCostumbresParticipaChanged(selectedItems));
}

void _handleOptionIdSelection(
    BuildContext context,
    bool value,
    List<LstEventoCostumbreParticipa> selectedItems,
    int eventoCostumbreParticipaId,
    int optionId) {
  _updateSelectedItemsWithOptionId(
      value, selectedItems, eventoCostumbreParticipaId, optionId);
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    List<LstEventoCostumbreParticipa> selectedItems,
    int eventoCostumbreParticipaId) {
  _updateSelectedItemsRegular(value, selectedItems, eventoCostumbreParticipaId);
}

void _updateSelectedItemsWithOptionId(
    bool value,
    List<LstEventoCostumbreParticipa> selectedItems,
    int eventoCostumbreParticipaId,
    int optionId) {
  if (eventoCostumbreParticipaId == optionId) {
    selectedItems.clear();
    selectedItems
        .add(LstEventoCostumbreParticipa(eventoCostumbreParticipaId: optionId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.eventoCostumbreParticipaId == optionId);
    selectedItems.add(LstEventoCostumbreParticipa(
        eventoCostumbreParticipaId: eventoCostumbreParticipaId));
  } else {
    selectedItems.removeWhere(
        (e) => e.eventoCostumbreParticipaId == eventoCostumbreParticipaId);
  }
}

void _updateSelectedItemsRegular(
    bool value,
    List<LstEventoCostumbreParticipa> selectedItems,
    int eventoCostumbreParticipaId) {
  if (value) {
    selectedItems.add(LstEventoCostumbreParticipa(
        eventoCostumbreParticipaId: eventoCostumbreParticipaId));
  } else {
    selectedItems.removeWhere(
        (e) => e.eventoCostumbreParticipaId == eventoCostumbreParticipaId);
  }
}
