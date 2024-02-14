import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = 'SandyydnaS';
  String _email = 'choi.s@gmail.com';
  String _phoneNumber = '+14987889999';
  String _password = '********';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF47DB91),
        title: Text('Profile'),
      ),
      backgroundColor: Color(0xFFF8FAED),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centering content
          children: [
            GestureDetector(
              onTap: _changePicture,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/profile.png'), // Change this to your default profile picture
              ),
            ),
            SizedBox(height: 20.0),
            Text('Username: $_username'),
            Text('Email: $_email'),
            Text('Phone Number: $_phoneNumber'),
            Text('Password: $_password'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF50A65C), // Change this to the desired color
                textStyle: TextStyle(color: Colors.white),
              ),
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  void _changePicture() {
    // Implement logic to change the profile picture
    // For example, you can use image picker package to select an image
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the current profile data
    _usernameController.text = 'SandyydnaS';
    _emailController.text = 'choi.s@gmail.com';
    _phoneNumberController.text = '+14987889999';
    _passwordController.text = '*********';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF47DB91), // Change header color here
        title: Text('Edit Profile'),
      ),
      backgroundColor: Color(0xFFF8FAED), // Change background color here
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centering content
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email ID'),
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF50A65C), // Change this to the desired color
                textStyle: TextStyle(color: Colors.white),
              ),
              onPressed: _saveProfile,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() {
    // Implement logic to save the edited profile information
    String newUsername = _usernameController.text;
    String newEmail = _emailController.text;
    String newPhoneNumber = _phoneNumberController.text;
    String newPassword = _passwordController.text;

    // Save the data wherever you need
    // For example, you can update state in ProfilePage or save it to a database

    // Navigate back to ProfilePage
    Navigator.pop(context);
  }
}
