import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomTabs(),
    );
  }
}

class BottomTabs extends StatefulWidget {
  const BottomTabs({Key? key}) : super(key: key);

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Container(
      color: Colors.blue,
    ),
    NotificationDemo(),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.purple,
    ),
    Container(
      color: Colors.yellow,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(30), // Set border radius here
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF232323), // Set the background color here
            borderRadius: BorderRadius.circular(30), // Set border radius here
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              rippleColor:
                  Color(0xFF50A65C), // tab button ripple color when pressed
              hoverColor: Color(0xFFF1F3E6), // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 20,
              tabActiveBorder: Border.all(
                  color: Colors.black, width: 1), // tab button border
              gap: 8, // the tab button gap between icon and text
              color: Color(0xFF8D8E87), // unselected icon color
              activeColor: Color(0xFF232323), // selected icon and text color
              iconSize: 24, // tab button icon size
              tabBackgroundColor: Color(0xFF50A65C),
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 8), // navigation bar padding

              tabs: [
                GButton(
                  icon: Icons.people,
                  text: '',
                ),
                GButton(
                  icon: Icons.notifications_rounded,
                  text: '',
                ),
                GButton(
                  icon: Icons.dashboard_rounded,
                  text: '',
                ),
                GButton(
                  icon: Icons.home,
                  text: '',
                ),
                GButton(
                  icon: Icons.settings,
                  text: '',
                ),
              ],
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationDemo extends StatefulWidget {
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
      'Take the house key with you',
      'Turn off the gas',
      'Turn off the water'
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
      Icons.vpn_key,
      Icons.local_fire_department,
      Icons.water_drop
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
                          'Hi Sandy!',
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
                  onPressed: _addTask,
                  tooltip: 'Add Task',
                  child: Icon(Icons.add),
                  backgroundColor:
                      Color(0xFF232323), // Set background color to black
                  foregroundColor: Colors.white, // Set icon color to white
                  shape: CircleBorder(), // Set shape to CircleBorder
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
