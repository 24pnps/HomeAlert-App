import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'notification_add.dart';
import 'notification_edit.dart';

class NotificationDemo extends StatefulWidget {
  final String username;

  NotificationDemo({required this.username});

  @override
  _NotificationDemoState createState() => _NotificationDemoState();
}

class _NotificationDemoState extends State<NotificationDemo> {
  int _notificationCount = 0;
  List<String> tasks = [];
  List<IconData> icons = [];
  List<String> times = [];
  List<Color> iconColors = [];
  List<String?> alertTimes = [];

  void _incrementNotificationCount() {
    setState(() {
      _notificationCount++;
    });
  }

  Map<String, MapEntry<IconData, Color>> predefinedIcons = {
    'laptop': MapEntry(Icons.business_center, Color.fromARGB(255, 0, 0, 0)),
    'key': MapEntry(Icons.vpn_key, Color.fromARGB(255, 0, 0, 0)),
    'document': MapEntry(Icons.description, Color.fromARGB(255, 0, 0, 0)),
    'water the plants': MapEntry(Icons.park, Color.fromARGB(255, 0, 0, 0)),
    'water': MapEntry(Icons.water_drop, const Color.fromARGB(255, 0, 0, 0)),
    'light': MapEntry(Icons.lightbulb, Color.fromARGB(255, 0, 0, 0)),
    'lock': MapEntry(Icons.lock, const Color.fromARGB(255, 0, 0, 0)),
    'gas': MapEntry(Icons.local_gas_station, Color.fromARGB(255, 0, 0, 0)),
    'wallet': MapEntry(
        Icons.account_balance_wallet, const Color.fromARGB(255, 0, 0, 0)),
  };

  @override
  void initState() {
    super.initState();
    // Fetch data from Firestore
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      // Query Firestore to get all documents from the 'Item' collection
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('Item').get();

      // Clear previous data
      tasks.clear();
      icons.clear();
      times.clear();
      alertTimes.clear();

      // Loop through the documents and extract itemName and itemDescription
      querySnapshot.docs.forEach((document) {
        var data = document.data();
        String? itemName = data['itemName'];
        String? itemDescription = data['itemDescription'];
        String? alertTime = data['alertTime'];

        // Add itemName, itemDescription, and alertTime to respective lists
        if (itemName != null && itemDescription != null) {
          tasks.add(itemName);
          times.add(itemDescription);
          alertTimes.add(alertTime);

          // If predefined icon exists for the itemName, use it; otherwise use a default icon
          IconData iconData = predefinedIcons.containsKey(itemName)
              ? predefinedIcons[itemName]!.key
              : Icons
                  .disabled_by_default; // Replace Icons.default with your default icon
          icons.add(iconData);

          // Print itemName, itemDescription, and alertTime for each document
          print(
              'Item Name: $itemName, Item Description: $itemDescription, Alert Time: $alertTime');
        }
      });

      // Update the UI
      setState(() {});

      print('Retrieved ${querySnapshot.size} items from Firestore');
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.notifications_on_outlined),
              iconSize: 30,
              onPressed: () {
                _incrementNotificationCount();
              },
            ),
          ),
        ],
        backgroundColor: const Color(0xFFF8FAED),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Hi ${widget.username}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 50.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Let me help remind you',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/Noti.png',
                  ),
                  Positioned(
                    top: 50,
                    left: 160,
                    child: Image.asset(
                      'assets/sky.png',
                      width: 120,
                      height: 100,
                    ),
                  ),
                  Positioned(
                    top: 230,
                    left: 80,
                    child: Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    top: 190,
                    left: 5,
                    child: IconButton(
                      icon: Icon(Icons.location_on),
                      iconSize: 70,
                      onPressed: () {
                        _incrementNotificationCount();
                      },
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    for (int i = 0; i < tasks.length; i++)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationEdit(
                                username: widget.username,
                                itemName: tasks[i],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xFFF1F3E6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color(0xFFE6E9D6),
                                    ),
                                    child: Icon(
                                      icons[i],
                                      color: const Color(0xFF232323),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        tasks[i],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        times[i],
                                        style: TextStyle(
                                          color: Color(0xFFDB36AD),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(Icons
                                      .access_time_filled), // Timer icon added here
                                  Text(alertTimes[i] ??
                                      'Default Time') // Text added below timer icon
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16.0, // Adjust bottom margin as needed
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddItemPage(username: widget.username)),
                    );
                  },
                  tooltip: 'Add Task',
                  child: Icon(Icons.add),
                  backgroundColor: Color(0xFF232323),
                  foregroundColor: Colors.white,
                  shape: CircleBorder(),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF8FAED),
    );
  }
}
