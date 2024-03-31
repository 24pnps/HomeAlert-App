import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/add_new_device.dart';
import 'pages/notification_add.dart';
import 'pages/register.dart';
import 'pages/task.dart';
import 'pages/launcher.dart';
import 'package:firebase_core/firebase_core.dart';
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
        '/add_new_device': (context) => AddNewDevice(),
        '/notification_add': (context) => AddItemPage(username: ""),
        '/signup': (context) => SignUp(),
        '/task': (context) => TaskPage(),
        '/launcher': (context) => Launcher(email: ""),
        '/AddNewDevice': (context) => AddNewDevice(),
      },
    );
  }
}
