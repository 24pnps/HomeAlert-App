import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'dart:convert';

class SettingsPage extends StatefulWidget {
  final String username;
  const SettingsPage({super.key, required this.username});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _profilePictureUrl =
      'https://img.freepik.com/premium-vector/grey-gradient-abstract-background-gray-background_322958-2628.jpg';
  bool pushNotificationsEnabled = true; // Initial state for push notifications
  bool darkModeEnabled = false; // Initial state for dark mode

  @override
  void initState() {
    super.initState();
    _fetchRandomPhoto();
  }

  Future<void> _fetchRandomPhoto() async {
    try {
      final photoUrl = await fetchRandomPhoto();
      setState(() {
        _profilePictureUrl = photoUrl;
      });
    } catch (error) {
      print('Error fetching random photo: $error');
    }
  }

  Future<String> fetchRandomPhoto() async {
    const apiKey = 'uOX7v4lxS1VaOBTljKpmKIj4qbiqhBsvv85AAatukBDUAcHWwaYxMw0B';
    const query = "portraits";
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$query&per_page=1&page=15'),
        headers: {
          'Authorization': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final photoUrl = jsonData['photos'][0]['src']['large'];
        return photoUrl;
      } else {
        throw Exception('Failed to load photo');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF50A65C), // Set the background color to green
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.settings,
                  size: 30, color: Colors.white), // Settings icon
              const SizedBox(width: 5), // Spacer between icon and text
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
        decoration: const BoxDecoration(
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
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: _profilePictureUrl != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(_profilePictureUrl),
                        )
                      : const CircularProgressIndicator(), // Placeholder until the image loads
                  title: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('User')
                        .doc(user!.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const Text('Username not available');
                      }
                      final username = snapshot.data!['username'];
                      return Text(
                        '$username',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(),
                      );
                    },
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
                  leading: const Icon(Icons.lock),
                  title: Text(
                    'Change password',
                    style: GoogleFonts.poppins(),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.payment),
                  title: Text(
                    'Add a payment method',
                    style: GoogleFonts.poppins(),
                  ),
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.notifications), // Icon for dark mode
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
                  secondary: const Icon(Icons.dark_mode), // Icon for dark mode
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
                const Divider(), // Separator
                const ListTile(
                  title: Text(
                    'More',
                    style: TextStyle(
                      color: Colors.grey, // Set text color to grey
                    ),
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(
                    'About us',
                    style: GoogleFonts.poppins(),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: Text(
                    'Privacy policy',
                    style: GoogleFonts.poppins(),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: Text(
                    'Terms and conditions',
                    style: GoogleFonts.poppins(),
                  ),
                ),
                const Divider(), // Separator
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ],
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
