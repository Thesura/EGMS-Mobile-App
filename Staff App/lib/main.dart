import 'package:flutter/material.dart';
import 'package:egms_app_2/Login.dart';
import 'package:egms_app_2/Home.dart';
import 'package:egms_app_2/Outages.dart';
import 'package:egms_app_2/Landing.dart';
import 'package:egms_app_2/Map.dart';
import 'package:egms_app_2/repair.dart';

void main() => runApp(MaterialApp(
  title: "EGMS",
  initialRoute: '/',
  routes: {
    '/' : (context) => LandingPage(),
    '/login' : (context) => LoginPage(),
    '/home' : (context) => HomePage(),
    '/outages' : (context) => OutagesPage(),
    '/map' : (context) => MapPage(),
  },
));

