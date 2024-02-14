import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/schema/device.dart';
import 'package:provider/provider.dart';
import '../util/device_box.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // padding constants
  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  // list of smart devices
  List mySmartDevices = [
    // [ smartDeviceName, iconPath , powerStatus ]
    ["Light", "lib/assets/icons/light-bulb.png", true],
    ["Tap", "lib/assets/icons/water-tap.png", false],
    ["Bath tub", "lib/assets/icons/bathtub.png", false],
  ];

  // power button switched
  // void powerSwitchChanged(bool value, int index) {
  //   setState(() {
  //     mySmartDevices[index][2] = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     // menu icon
              //     Image.asset(
              //       'lib/icons/menu.png',
              //       height: 45,
              //       color: Colors.grey[800],
              //     ),

              //     // account icon
              //     Icon(
              //       Icons.person,
              //       size: 45,
              //       color: Colors.grey[800],
              //     )
              //   ],
              // ),
            ),

            const SizedBox(height: 20),

            // welcome home
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi Sandy!",
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Welcome to your home',
                    style: GoogleFonts.roboto(
                        fontSize: 16.0, color: Color(0xFF232323)),
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
                  // Add the vertical three-dot icon for "More"
                  GestureDetector(
                    onTap: () {
                      // Add the functionality you want when the "More" icon is tapped
                      // For example, you can show a dropdown menu or navigate to another screen.
                      Navigator.pushNamed(context, '/AddNewDevice');
                    },
                    child: Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.grey
                          .shade800, // You can change the color to your preference
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

// grid
            Expanded(
              child: Consumer(
                builder: (context, value, child) {
                  final deviceProvider = Provider.of<DeviceProvider>(context);
                  final devices = deviceProvider.devices;
                  return ListView.builder(
                    itemCount: (devices.length / 2)
                        .ceil(), // Adjusted to handle odd number of devices
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
                          SizedBox(width: 8), // Adjust as needed for spacing
                          Expanded(
                            child: secondIndex < devices.length
                                ? SmartDeviceBox(
                                    smartDeviceName:
                                        devices[secondIndex].smartDeviceName,
                                    iconPath: devices[secondIndex].deviceImage,
                                    powerOn: devices[secondIndex].isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        devices[secondIndex].isChecked =
                                            !devices[secondIndex].isChecked;
                                      });
                                      deviceProvider.notifyListeners();
                                    },
                                  )
                                : SizedBox(), // To handle odd number of devices
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            )
            // Expanded(
            //   child: Scrollbar(
            //     child: GridView.builder(
            //       itemCount: 3,
            //       // Removed physics: const NeverScrollableScrollPhysics(),
            //       padding: const EdgeInsets.symmetric(horizontal: 25),
            //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2,
            //         childAspectRatio: 1 / 1.3,
            //       ),
            //       itemBuilder: (context, index) {
            //         return SmartDeviceBox(
            //           smartDeviceName: mySmartDevices[index][0],
            //           iconPath: mySmartDevices[index][1],
            //           powerOn: mySmartDevices[index][2],
            //           onChanged: (value) => powerSwitchChanged(value, index),
            //         );
            //       },
            //     ),
            //   ),
            // )
          ],
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
    // Implement the logic for displaying room images here
    return Container(
        margin: EdgeInsets.all(20.0),
        child: Center(
            child: Container(
                width: 150,
                height: 150,
                child: Image.asset('lib/assets/Bath.png',
                    fit: BoxFit.fitHeight))));
  }
}
