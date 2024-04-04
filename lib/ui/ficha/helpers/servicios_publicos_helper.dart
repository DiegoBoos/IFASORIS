import 'package:flutter/material.dart';

import '../../../data/models/servicio_publico_vivienda_model.dart';
import '../../blocs/dim_vivienda/dim_vivienda_bloc.dart';

void handleServiciosPublicosSelection(
    FormFieldState<List<LstServPublico>> formState,
    int? ningunoId,
    BuildContext context,
    bool? value,
    int servicioPublicoViviendaId,
    DimViviendaBloc dimViviendaBloc) {
  var selectedItems = List<LstServPublico>.from(formState.value ?? []);

  if (ningunoId != null) {
    _handleNingunoIdSelection(
        context, value!, selectedItems, servicioPublicoViviendaId, ningunoId);
  } else {
    _handleRegularSelection(
        context, value!, selectedItems, servicioPublicoViviendaId);
  }

  formState.didChange(selectedItems);
  dimViviendaBloc.add(ServiciosPublicosViviendaChanged(selectedItems));
}

void _handleNingunoIdSelection(
    BuildContext context,
    bool value,
    List<LstServPublico> selectedItems,
    int servicioPublicoViviendaId,
    int ningunoId) {
  _updateSelectedItemsWithNingunoId(
      value, selectedItems, servicioPublicoViviendaId, ningunoId);
}

void _handleRegularSelection(BuildContext context, bool value,
    List<LstServPublico> selectedItems, int servicioPublicoViviendaId) {
  _updateSelectedItemsRegular(value, selectedItems, servicioPublicoViviendaId);
}

void _updateSelectedItemsWithNingunoId(
    bool value,
    List<LstServPublico> selectedItems,
    int servicioPublicoViviendaId,
    int ningunoId) {
  if (servicioPublicoViviendaId == ningunoId) {
    selectedItems.clear();
    selectedItems.add(LstServPublico(servicioPublicoViviendaId: ningunoId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.servicioPublicoViviendaId == ningunoId);
    selectedItems.add(
        LstServPublico(servicioPublicoViviendaId: servicioPublicoViviendaId));
  } else {
    selectedItems.removeWhere(
        (e) => e.servicioPublicoViviendaId == servicioPublicoViviendaId);
  }
}

void _updateSelectedItemsRegular(bool value, List<LstServPublico> selectedItems,
    int servicioPublicoViviendaId) {
  if (value) {
    selectedItems.add(
        LstServPublico(servicioPublicoViviendaId: servicioPublicoViviendaId));
  } else {
    selectedItems.removeWhere(
        (e) => e.servicioPublicoViviendaId == servicioPublicoViviendaId);
  }
}
