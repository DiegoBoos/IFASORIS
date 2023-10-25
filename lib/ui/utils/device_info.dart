import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/equipo_entity.dart';

class DeviceInfo {
  static Future<EquipoEntity?> infoDispositivo() async {
    EquipoEntity datosEquipo = EquipoEntity();
    try {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo data = await deviceInfoPlugin.androidInfo;
        datosEquipo.idEquipo = data.id;
        datosEquipo.modeloEquipo = data.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
        datosEquipo.idEquipo = data.identifierForVendor;
        datosEquipo.modeloEquipo = data.model;
      }
      return datosEquipo;
    } on PlatformException {
      return null;
    }
  }
}
