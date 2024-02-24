import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class device {
  final String smartDeviceName;
  String deviceImage;
  bool isChecked;

  device({
    required this.smartDeviceName,
    this.deviceImage = "assets/icons/fan.png",
    this.isChecked = false,
  });
}

class DeviceProvider with ChangeNotifier {
  List<device> _devices = [
    device(
        deviceImage: "assets/icons/light-bulb.png",
        smartDeviceName: "Light bulb",
        isChecked: false),
    device(
        deviceImage: "assets/icons/water-tap.png",
        smartDeviceName: "Tap",
        isChecked: false),
    device(
        deviceImage: "assets/icons/bathtub.png",
        smartDeviceName: "Bath tub",
        isChecked: false),
  ];

  List get devices {
    return [..._devices];
  }

  void addDevice(device newDevice) {
    _devices.add(newDevice);
    notifyListeners();
  }

  void removeDevice(device device) {
    _devices.remove(device);
    notifyListeners();
  }
}
