import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/schema/device.dart';
import 'package:provider/provider.dart';
import '../util/device_box.dart';
import 'package:flutter/services.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // padding constants
  final double horizontalPadding = 20;
  final double verticalPadding = 25;

  @override
  Widget build(BuildContext context) {
    // Create the DeviceProvider here
    final deviceProvider =
        DeviceProvider(); // Assuming DeviceProvider is a ChangeNotifier

    return ChangeNotifierProvider(
      create: (context) => deviceProvider,
      child: Scaffold(
        backgroundColor: Color(0xFFFEFAED),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // app bar
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                // Add your app bar widgets here
                // ...
              ),

              const SizedBox(height: 20),

              // welcome home
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Home",
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Let\'s comfirm your activity',
                      // Add Google Fonts here if needed
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xFF232323)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              RoomSelector(),
              Expanded(
                child: RoomImage(),
              ),

              const SizedBox(height: 25),

              // smart devices grid
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Devices",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/AddNewDevice');
                      },
                      child: Icon(
                        Icons.add,
                        size: 24,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // grid
              Expanded(
                child: Consumer<DeviceProvider>(
                  builder: (context, deviceProvider, _) {
                    final devices = deviceProvider.devices;
                    return ListView.builder(
                      itemCount: (devices.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        final int firstIndex = index * 2;
                        final int secondIndex = firstIndex + 1;

                        return Row(
                          children: [
                            Expanded(
                              child: SmartDeviceBox(
                                smartDeviceName:
                                    devices[firstIndex].smartDeviceName,
                                iconPath: devices[firstIndex].deviceImage,
                                powerOn: devices[firstIndex].isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    devices[firstIndex].isChecked =
                                        !devices[firstIndex].isChecked;
                                  });
                                  deviceProvider.notifyListeners();
                                },
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: secondIndex < devices.length
                                  ? SmartDeviceBox(
                                      smartDeviceName:
                                          devices[secondIndex].smartDeviceName,
                                      iconPath:
                                          devices[secondIndex].deviceImage,
                                      powerOn: devices[secondIndex].isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          devices[secondIndex].isChecked =
                                              !devices[secondIndex].isChecked;
                                        });
                                        deviceProvider.notifyListeners();
                                      },
                                    )
                                  : SizedBox(),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RoomSelector extends StatefulWidget {
  @override
  _RoomSelectorState createState() => _RoomSelectorState();
}

class _RoomSelectorState extends State<RoomSelector> {
  int selectedRoomIndex = 0;

  List<RoomItem> roomItems = [
    RoomItem('Shower', 'Bathroom', Icons.bathtub),
    RoomItem('Bed', 'Bedroom', Icons.bed),
    RoomItem('Salad Bowl', 'Dining', Icons.rice_bowl),
    RoomItem('Car', 'Garage', Icons.directions_car),
    RoomItem('Pot', 'Kitchen', Icons.kitchen),
    RoomItem('Washer Machine', 'Laundry', Icons.local_laundry_service),
    RoomItem('Sofa', 'Living', Icons.weekend),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: roomItems
              .asMap()
              .entries
              .map(
                (entry) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRoomIndex = entry.key;
                    });
                  },
                  child: RoomBox(
                    title: entry.value.title,
                    subtitle: entry.value.subtitle,
                    icon: entry.value.icon,
                    isSelected: selectedRoomIndex == entry.key,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class RoomBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;

  RoomBox({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 81.0,
      margin: EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF50A65C) : Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: isSelected ? Colors.transparent : Color(0xFF232323),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Color(0xFF232323),
            size: 42.0,
          ),
          SizedBox(height: 5.0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              color: isSelected ? Colors.white : Color(0xFF232323),
            ),
          ),
        ],
      ),
    );
  }
}

class RoomItem {
  final String title;
  final String subtitle;
  final IconData icon;

  RoomItem(this.title, this.subtitle, this.icon);
}

class RoomImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Center(
        child: Container(
          width: 300,
          height: 300,
          child: Image.asset('assets/Bath.png', fit: BoxFit.fitHeight),
        ),
      ),
    );
  }
}
