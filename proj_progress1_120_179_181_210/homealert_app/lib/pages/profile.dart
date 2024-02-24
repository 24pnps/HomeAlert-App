import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'update.dart';

class ProfilePage extends StatefulWidget {
  final String email;

  ProfilePage({required this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = '';
  String _email = '';
  String _phoneNumber = '';
  String _password = '********';
  String _profilePictureUrl =
      'https://img.freepik.com/premium-vector/grey-gradient-abstract-background-gray-background_322958-2628.jpg';

  @override
  void initState() {
    super.initState();
    _fetchRandomPhoto();
    _fetchUserData();
    _email = widget.email;
  }

  Future<void> _fetchUserData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('User')
          .where('email', isEqualTo: widget.email)
          .get();

      if (userData.docs.isNotEmpty) {
        setState(() {
          _username = userData.docs.first['username'];
          _email = userData.docs.first['email'];
          _phoneNumber = userData.docs.first['phoneNumber'];
        });
      } else {
        print('No user data found for email: ${widget.email}');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
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
    final apiKey = 'uOX7v4lxS1VaOBTljKpmKIj4qbiqhBsvv85AAatukBDUAcHWwaYxMw0B';
    final query = "portraits";
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
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAED),
        leading: IconButton(
            onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            // Use GoogleFonts.poppins for the desired font
            textStyle: Theme.of(context).textTheme.headline4,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      backgroundColor: const Color(0xFFF8FAED),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: _profilePictureUrl != null
                          ? Image.network(
                              _profilePictureUrl!,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            )
                          : CircularProgressIndicator(), // Placeholder until the image is loaded
                    ),
                  ),
                  Positioned(
                    // Positioned widget is needed to position the icon within the Stack
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xFF50A65C),
                      ),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '$_username',
                style: GoogleFonts.poppins(
                  // Use GoogleFonts.poppins for the desired font
                  textStyle: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text(
                '$_email',
                style: GoogleFonts.poppins(
                  // Use GoogleFonts.poppins for the desired font
                  textStyle: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdatePage(email: _email)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF50A65C),
                    side: BorderSide.none, // Remove the const keyword here
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              //Menu
              ProfileMenu(
                  title: "Settings",
                  icon: LineAwesomeIcons.cog,
                  onPress: () {}),
              ProfileMenu(
                  title: "Details",
                  icon: LineAwesomeIcons.wallet,
                  onPress: () {}),
              ProfileMenu(
                  title: "User Management",
                  icon: LineAwesomeIcons.user_check,
                  onPress: () {}),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              ProfileMenu(
                  title: "Information",
                  icon: LineAwesomeIcons.info,
                  onPress: () {}),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(
                      vertical: 12, horizontal: 16), // Add padding
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      LineAwesomeIcons.alternate_sign_out,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPress,
      this.endIcon = true,
      this.textColor})
      : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? Color(0xFFF8FAED) : Color(0xFF232323);

    return ListTile(
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color(0xFF50A65C).withOpacity(0.1)),
        child: const Icon(LineAwesomeIcons.angle_right,
            size: 18.0, color: Color(0xFF50A65C)),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(LineAwesomeIcons.angle_right,
                  size: 18.0, color: Colors.grey))
          : null,
    );
  }
}



/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final String email;

  ProfilePage({required this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = '';
  String _email = '';
  String _phoneNumber = '';
  String _password = '********';
  String? _profilePictureUrl =
      'https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _email = widget.email;
  }

  Future<void> _fetchUserData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('User')
          .where('email', isEqualTo: widget.email)
          .get();

      if (userData.docs.isNotEmpty) {
        setState(() {
          _username = userData.docs.first['username'];
          _email = userData.docs.first['email'];
          _phoneNumber = userData.docs.first['phoneNumber'];
        });
      } else {
        print('No user data found for email: ${widget.email}');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF47DB91),
        title: Text('Profile'),
      ),
      backgroundColor: Color(0xFFF8FAED),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _changePicture,
              child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_profilePictureUrl.toString())),
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
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(email: widget.email),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
              ),
              child: Text('Edit Profile'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
              ),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  void _changePicture() async {
    final String apiKey =
        'uOX7v4lxS1VaOBTljKpmKIj4qbiqhBsvv85AAatukBDUAcHWwaYxMw0B';
    final String query = 'Tiger';

    final response = await http.get(
      // Uri.parse('https://api.pexels.com/v1/search?query=$query'),
      Uri.parse('https://api.pexels.com/v1/photos/2014422'),
      headers: {'Authorization': apiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final photoUrl = data['photos'][0]['src']['medium'];

      setState(() {
        _profilePictureUrl = photoUrl;
      });
    } else {
      print('Failed to fetch profile picture: ${response.statusCode}');
    }
  }
}

class EditProfilePage extends StatefulWidget {
  final String email;

  EditProfilePage({required this.email});

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
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection('User')
        .where('email', isEqualTo: widget.email)
        .get();

    if (userData.docs.isNotEmpty) {
      setState(() {
        _usernameController.text = userData.docs.first['username'];
        _emailController.text = userData.docs.first['email'];
        _phoneNumberController.text = userData.docs.first['phoneNumber'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF47DB91),
        title: Text('Edit Profile'),
      ),
      backgroundColor: Color(0xFFF8FAED),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
    String newUsername = _usernameController.text;
    String newEmail = _emailController.text;
    String newPhoneNumber = _phoneNumberController.text;
    String newPassword = _passwordController.text;

    FirebaseFirestore.instance.collection('User').doc(widget.email).update({
      'username': newUsername,
      'email': newEmail,
      'phoneNumber': newPhoneNumber,
    });

    Navigator.pop(context);
  }
}
*/