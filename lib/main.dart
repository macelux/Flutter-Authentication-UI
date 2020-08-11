import 'package:authentication_ui/screens/LoginScreen.dart';
import 'package:authentication_ui/screens/login.dart';
import 'package:flutter/material.dart';


void main() {  runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication Demo',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Login(),
    );
  }
}