import 'package:flutter/material.dart';
import 'package:project/schema/device.dart';
import 'package:provider/provider.dart';

class AddNewDevice extends StatefulWidget {
  const AddNewDevice({super.key});

  @override
  State<AddNewDevice> createState() => _AddNewDeviceState();
}

class _AddNewDeviceState extends State<AddNewDevice> {
  final TextEditingController _deviceNameController = TextEditingController();
  final TextEditingController _deviceImageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _deviceNameController,
              decoration: InputDecoration(
                labelText: 'Device Name',
              ),
            ),
            // TextField(
            //   controller: _deviceImageController,
            //   decoration: InputDecoration(
            //     labelText: 'Device Image',
            //   ),
            // ),
            ElevatedButton(
              onPressed: () {
                Provider.of<DeviceProvider>(context, listen: false).addDevice(
                  device(
                    smartDeviceName: _deviceNameController.text,
                    // deviceImage: _deviceImageController.text,
                  ),
                );
                Navigator.pop(context);
              },
              child: Text('Add Device'),
            ),
          ],
        ),
      ),
    );
  }
}