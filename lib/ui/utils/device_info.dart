import 'dart:io';
import 'package:device_information/device_information.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/entities/equipo_entity.dart';

class DeviceInfo {
  static Future<EquipoEntity?> infoDispositivo() async {
    EquipoEntity datosEquipo = EquipoEntity();

    if (Platform.isAndroid) {
      var status = await Permission.phone.status;
      if (!status.isGranted) {
        status = await Permission.phone.request();
      }

      if (status.isGranted) {
        return await retrieveDeviceInfo(datosEquipo);
      }
    } else if (Platform.isIOS) {
      return await retrieveDeviceInfo(datosEquipo);
    }
    return null;
  }

  static Future<EquipoEntity> retrieveDeviceInfo(
      EquipoEntity datosEquipo) async {
    final imei = await DeviceInformation.deviceIMEINumber;
    final deviceModel = await DeviceInformation.deviceModel;

    datosEquipo.imei = imei;
    datosEquipo.modeloEquipo = deviceModel;

    return datosEquipo;
  }
}
