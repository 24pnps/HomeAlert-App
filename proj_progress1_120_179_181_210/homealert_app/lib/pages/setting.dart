import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  final String username;

  SettingsPage({required this.username});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _username = '';
  String _profilePictureUrl =
      'https://img.freepik.com/premium-vector/grey-gradient-abstract-background-gray-background_322958-2628.jpg';

  bool pushNotificationsEnabled = true; // Initial state for push notifications
  bool darkModeEnabled = false; // Initial state for dark mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF50A65C), // Set the background color to green
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.settings,
                  size: 30, color: Colors.white), // Settings icon
              SizedBox(width: 5), // Spacer between icon and text
              Text(
                'Settings',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ), // Settings text
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF50A65C),
              Color(0xFFF8FAED),
            ], // Green to White gradient
            stops: [0.3, 0.3], // Equal stop points to create a half-half effect
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    '$_username',
                    style: GoogleFonts.poppins(),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Account Settings',
                    style: GoogleFonts.poppins(
                      color: Colors.grey, // Set text color to grey
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text(
                    'Change password',
                    style: GoogleFonts.poppins(),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.payment),
                  title: Text(
                    'Add a payment method',
                    style: GoogleFonts.poppins(),
                  ),
                ),
                SwitchListTile(
                  secondary: Icon(Icons.notifications), // Icon for dark mode
                  title: Text(
                    'Push notifications',
                    style: GoogleFonts.poppins(),
                  ),
                  value: pushNotificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      pushNotificationsEnabled = value; // Update the state
                    });
                  },
                ),

                SwitchListTile(
                  secondary: Icon(Icons.dark_mode), // Icon for dark mode
                  title: Text(
                    'Dark mode',
                    style: GoogleFonts.poppins(),
                  ),
                  value: darkModeEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      darkModeEnabled = value; // Update the state
                    });
                  },
                ),
                Divider(), // Separator
                ListTile(
                  title: Text(
                    'More',
                    style: TextStyle(
                      color: Colors.grey, // Set text color to grey
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.info),
                  title: Text(
                    'About us',
                    style: GoogleFonts.poppins(),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.privacy_tip),
                  title: Text(
                    'Privacy policy',
                    style: GoogleFonts.poppins(),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.description),
                  title: Text(
                    'Terms and conditions',
                    style: GoogleFonts.poppins(),
                  ),
                ),
                Divider(), // Separator
                ListTile(
                  title: Text(
                    'Logout',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
