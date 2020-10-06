import 'package:Help_Desk/Screens/Home/add.dart';
import 'package:Help_Desk/Screens/Home/employee.dart';
import 'package:Help_Desk/Screens/Home/load.dart';
import 'package:Help_Desk/Screens/Home/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadScreens(),
    );
  }
}
