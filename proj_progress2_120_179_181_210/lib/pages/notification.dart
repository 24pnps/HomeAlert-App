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

  IconData mapItemNameToIcon(String itemName) {
    // Define keywords and their corresponding icons
    Map<String, IconData> keywordsToIcons = {
      'laptop': Icons.laptop_mac,
      'key': Icons.vpn_key,
      'document': Icons.description,
      'water': Icons.water_drop,
      'light': Icons.lightbulb,
      'lock': Icons.lock,
      'gas': Icons.local_gas_station,
      'wallet': Icons.account_balance_wallet,
      'phone': Icons.phone,
      'call': Icons.phone,
      'book': Icons.menu_book,
      'medicine': Icons.local_pharmacy,
      'headphones': Icons.headphones,
      'umbrella': Icons.beach_access,
      'charger': Icons.battery_charging_full,
      'bag': Icons.shopping_bag,
      'id card': Icons.badge,
      'credit card': Icons.credit_card,
      'mask': Icons.masks,
      'snacks': Icons.fastfood,
      'hat': Icons.wb_sunny,
      'watch': Icons.watch,
      'pen': Icons.create,
      'brush': Icons.brush,
      'sunglasses': Icons.visibility,
    };

    // Loop through keywords and check if the itemName contains any of them
    for (var keyword in keywordsToIcons.keys) {
      if (itemName.toLowerCase().contains(keyword)) {
        return keywordsToIcons[keyword]!;
      }
    }

    // If no keyword matches, return a default icon
    return Icons.disabled_by_default;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('Item')
          .orderBy('alertTime')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child:
                CircularProgressIndicator(), // Show loading indicator while data is being fetched
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
                'Error: ${snapshot.error}'), // Show error message if data fetching fails
          );
        }

        // Extract data from snapshot
        List<String> tasks = [];
        List<IconData> icons = [];
        List<String> times = [];
        List<String?> alertTimes = [];

        snapshot.data!.docs.forEach((document) {
          var data = document.data();
          String? itemName = data['itemName'];
          String? itemDescription = data['itemDescription'];
          String? alertTime = data['alertTime'];

          if (itemName != null && itemDescription != null) {
            tasks.add(itemName);
            times.add(itemDescription);
            alertTimes.add(alertTime);

            IconData iconData = mapItemNameToIcon(itemName);
            icons.add(iconData);
          }
        });

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
                              'Hi ${widget.username}!',
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
                          Dismissible(
                            key: Key(tasks[i]), // Unique key for each item
                            direction: DismissDirection
                                .endToStart, // Allow swipe from end to start (right to left)
                            onDismissed: (direction) async {
                              // Find the document ID based on the task name
                              QuerySnapshot<Map<String, dynamic>>
                                  querySnapshot = await FirebaseFirestore
                                      .instance
                                      .collection('Item')
                                      .where('itemName', isEqualTo: tasks[i])
                                      .get();

                              // Check if there's a matching document
                              if (querySnapshot.docs.isNotEmpty) {
                                // Delete the document
                                await FirebaseFirestore.instance
                                    .collection('Item')
                                    .doc(querySnapshot.docs.first.id)
                                    .delete();

                                // Update local state to reflect the change
                                setState(() {
                                  tasks.removeAt(i);
                                  icons.removeAt(i);
                                  times.removeAt(i);
                                  alertTimes.removeAt(i);
                                });
                              }
                            },
                            background: Container(
                              color:
                                  Colors.red, // Red background color for delete
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(
                                  right: 20.0), // Adjust padding as needed
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            child: GestureDetector(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                        Text(
                                          alertTimes[i] ?? 'Default Time',
                                        ), // Text added below timer icon
                                      ],
                                    ),
                                  ],
                                ),
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
      },
    );
  }
}
