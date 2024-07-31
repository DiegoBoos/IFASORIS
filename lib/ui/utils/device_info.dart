import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/equipo.dart';

class DeviceInfo {
  static Future<Equipo?> infoDispositivo() async {
    Equipo datosEquipo = const Equipo();
    try {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo data = await deviceInfoPlugin.androidInfo;
        datosEquipo.copyWith(idEquipo: data.id);
        datosEquipo.copyWith(modeloEquipo: data.model);
      } else if (Platform.isIOS) {
        IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
        datosEquipo.copyWith(idEquipo: data.identifierForVendor);
        datosEquipo.copyWith(modeloEquipo: data.model);
      }
      return datosEquipo;
    } on PlatformException {
      return null;
    }
  }
}
