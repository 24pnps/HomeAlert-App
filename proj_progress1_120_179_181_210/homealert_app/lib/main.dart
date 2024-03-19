import 'package:flutter/material.dart';
import 'package:homealert_app/pages/home.dart';
import 'pages/login.dart';
import 'pages/profile.dart';
import 'pages/add_new_device.dart';
import 'pages/notification_add.dart';
import 'pages/home.dart';
import 'pages/setting.dart';
import 'pages/notification_edit.dart';
import 'pages/notification.dart';
import 'pages/register.dart';
import 'pages/task.dart';
import 'pages/launcher.dart';
import 'schema/device.dart';
import 'util/device_box.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Workshop1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/login': (context) => Login(),
        '/home': (context) => HomePage(username: ""),
        '/setting' : (context) => SettingsPage(username: ""),
        '/add_new_device': (context) => AddNewDevice(),
        '/notification_add': (context) => AddItemPage(),
        '/notification_edit': (context) => NotificationEdit(),
        '/notification': (context) => NotificationDemo(username: ""),
        '/signup': (context) => SignUp(),
        '/task': (context) => TaskPage(),
        '/launcher': (context) => Launcher(email: ""),
        '/AddNewDevice': (context) => AddNewDevice(),
      },
    );
  }
}