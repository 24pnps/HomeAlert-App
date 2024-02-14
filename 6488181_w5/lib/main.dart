import 'package:flutter/material.dart';
import 'package:project/pages/add_new_device.dart';
import 'package:project/schema/device.dart';
import 'pages/task_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

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
    Container(
      color: Colors.pink,
    ),
    Container(
      color: Colors.green,
    ),
    HomePage(),
    Container(
      color: Colors.yellow,
    ),
  ];

  @override
   Widget _buttomNavbar(BuildContext context) {
    return ClipRRect(
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
            tabActiveBorder:
                Border.all(color: Colors.black, width: 1), // tab button border
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DeviceProvider(),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => Scaffold(
                  body: _pages[_selectedIndex],
                  bottomNavigationBar: _buttomNavbar(context),
                ),
            '/AddNewDevice': (context) => AddNewDevice(),
          },
        ));
  }
}
