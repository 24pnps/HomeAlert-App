import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'update.dart';

class UpdatePage extends StatefulWidget {
  final String email;

  UpdatePage({required this.email});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController =
      TextEditingController(text: '********');
  String _profilePictureUrl =
      'https://img.freepik.com/premium-vector/grey-gradient-abstract-background-gray-background_322958-2628.jpg';

  @override
  void initState() {
    super.initState();
    _fetchRandomPhoto();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAED),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.headline4,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF8FAED),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
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
                        LineAwesomeIcons.camera,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller:
                          _usernameController, // Display existing username
                      decoration: InputDecoration(
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      ),
                    ), // TextFormField

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      ),
                    ), // TextFormField

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      ),
                    ), // TextFormField

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.fingerprint),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to profile page
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        const Color(0xFF50A65C), // Text color of button
                  ),
                  child: const Text("Save"), // Text of button/ Text of button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
