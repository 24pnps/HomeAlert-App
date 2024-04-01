import 'package:flutter/material.dart';
import 'profile.dart';
import 'notification.dart';
import 'task.dart';
import '../util/device_box.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Launcher extends StatefulWidget {
  final String email;

  const Launcher({Key? key, required this.email}) : super(key: key);

  @override
  _LauncherState createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  int _selectedIndex = 0;
String _username = '';
  late List<Widget> _pages;

Future<void> _fetchUserData() async {
  // Query Firestore to get user data based on email
  QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
      .instance
      .collection('User')
      .where('email', isEqualTo: widget.email)
      .get();

  // Populate _username with retrieved user data
  if (userData.docs.isNotEmpty) {
    setState(() {
      _username = userData.docs.first['username'];
    });
  }
}

  
@override
void initState() {
  super.initState();
  _pages = [
    ProfilePage(email: widget.email),
    Container(), // Placeholder for NotificationDemo
    Container(
      color: Colors.green,
    ),
    TaskPage(),
    Container(
      color: Colors.yellow,
    ),
  ];

  _fetchUserData().then((_) {
    // After fetching user data, update NotificationDemo with username and email
    _pages[1] = NotificationDemo(username: _username, email: widget.email);
    setState(() {}); // Update state to reflect changes
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _bottomNavbar(context),
    );
  }

  Widget _bottomNavbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          // Red-colored space outside the curved border
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
          // Bottom navigation bar
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF232323),
                borderRadius: BorderRadius.circular(30),
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
                  rippleColor: Color(0xFF50A65C),
                  hoverColor: Color(0xFFF1F3E6),
                  haptic: true,
                  tabBorderRadius: 20,
                  tabActiveBorder: Border.all(color: Colors.black, width: 1),
                  gap: 8,
                  color: Color(0xFF8D8E87),
                  activeColor: Color(0xFF232323),
                  iconSize: 24,
                  tabBackgroundColor: Color(0xFF50A65C),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
        ],
      ),
    );
  }
}
