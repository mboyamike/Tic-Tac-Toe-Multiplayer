import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tttm/SinglePlayer.dart';
import 'package:tttm/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primaryColor: Colors.black),
      routes: {
        "/": (context) => HomePage(),
      },
    );
  }
}