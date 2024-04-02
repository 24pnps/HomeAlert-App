import 'package:flutter/material.dart';
import 'pages/login.dart';
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
      title: 'HomeAlert app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/login': (context) => Login(),
        '/notification_add': (context) => AddItemPage(username: "",email: ""),
        '/signup': (context) => SignUp(),
        '/task': (context) => MainHome(username: ""),
        '/launcher': (context) => Launcher(email: ""),
      },
    );
  }
}
