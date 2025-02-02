import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/equipo.dart';

class DeviceInfo {
  static Future<Equipo?> infoDispositivo() async {
    try {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo data = await deviceInfoPlugin.androidInfo;
        return Equipo(idEquipo: data.id, modeloEquipo: data.model);
      } else if (Platform.isIOS) {
        IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
        return Equipo(
            idEquipo: data.identifierForVendor, modeloEquipo: data.model);
      }
      return null;
    } on PlatformException {
      return null;
    }
  }
}
