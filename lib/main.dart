import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Auth/LogIn.dart';
import 'Landing.dart';
import 'Screens/Admin/Home.dart';


void main() {
  runApp(const StudyPlus());
}

class StudyPlus extends StatefulWidget {
  const StudyPlus({super.key});

  @override
  State<StudyPlus> createState() => _StudyPlusState();
}

class _StudyPlusState extends State<StudyPlus> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes: {
        "/":(context) => Landing(),
        "Login":(context) => Login(),
        "Home" : (context) => Home(),
      },
      initialRoute: "/",
      debugShowCheckedModeBanner: false,

    );
  }
}
