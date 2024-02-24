import 'package:flutter/material.dart';
import 'notification_edit.dart';

class NotificationDemo extends StatefulWidget {

  final String username;

  NotificationDemo({required this.username});

  @override
  _NotificationDemoState createState() => _NotificationDemoState();
}

class _NotificationDemoState extends State<NotificationDemo> {
  int _notificationCount = 0;


  void _incrementNotificationCount() {
    setState(() {
      _notificationCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> tasks = [
      'Bring Laptop',
      'House Key',
      'Tax Documentation'
    ];
    List<IconData> iconsCheck = [
      Icons.vpn_key,
      Icons.local_fire_department,
      Icons.water_drop
    ];
    List<String> times = ['* New', 'Done', 'Done'];
    List<String> timerTexts = [
      '25 mins',
      '50 mins',
      '55 mins'
    ]; // Texts for timer below the icon
    List<IconData> icons = [
      Icons.business_center,
      Icons.vpn_key,
      Icons.description
    ];

    void _addTask() {
      setState(() {
        tasks.add('New Task');
        iconsCheck.add(Icons.add);
        times.add('* New');
        timerTexts.add('0 mins');
      });
    }

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
                      Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text(timerTexts[
                                    i]) // Text added below timer icon
                              ],
                            ),
                          ],
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
      MaterialPageRoute(builder: (context) => NotificationEdit()),
    );
  },
  tooltip: 'Add Task',
  child: Icon(Icons.add),
  backgroundColor: Color(0xFF232323),
  foregroundColor: Colors.white,
  shape: CircleBorder(),
),

              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF8FAED),
    );
  }
}
