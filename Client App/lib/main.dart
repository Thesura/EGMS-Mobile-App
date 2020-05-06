import 'package:flutter/material.dart';
import 'package:egms_app/Landing.dart';
import 'package:egms_app/Login.dart';
import 'package:egms_app/Register.dart';
import 'package:egms_app/Report.dart';
import 'package:egms_app/Home.dart';
import 'package:egms_app/Map.dart';
import 'package:egms_app/Profile.dart';
import 'package:egms_app/Schedule.dart';

void main() => runApp(MaterialApp(
  title: "EGMS",
  initialRoute: '/',
  routes: {
    '/' : (context) => LandingPage(),
    '/login' : (context) => LoginPage(),
    '/register' : (context) => RegisterPage(),
    '/home' : (context) => HomePage(),
    '/report' : (context) => ReportPage(),
    '/schedule' : (context) => SchedulePage(),
    '/map' : (context) => MapPage(),
  },
));
