import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/pages/HomePage.dart';
import 'package:myapp/pages/ImagePage.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    requestPermissions(); // Request permissions when the app starts
  }

  Future<void> requestPermissions() async {
    final status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      print('Storage permission granted');
    } else {
      print('Storage permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => HomePage(),
      },
    );
  }
}
