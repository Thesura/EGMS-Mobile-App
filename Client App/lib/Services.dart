import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:egms_app/apiConfig.dart' as config;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

class Services {
  Future<List> getSchedule() async {
    http.Response response = await http.get(config.url + "/schedules",
        headers: {"Accept": "application/json"});

    List schedule = jsonDecode(response.body);
    print(schedule[1]["type"]);

    return schedule;
  }

  checkSession(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getBool('isLoggedIn') != null && prefs.getBool('isLoggedIn') ){
       Navigator.pushNamed(context, '/home');
       }
       else{
       Navigator.pushNamed(context, '/login');
       }  
  }

  logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

     if(prefs.getBool('isLoggedIn')){

       prefs.clear();

       Navigator.pushNamed(context, '/');
       } 
  }

  login(BuildContext context, name, String pwd) async {
    Map login = {'name': name, 'password': pwd};

    http.Response response =
        await http.post(config.url + "/nonstaffusers/login",
            headers: {
              "Accept": "application/json",
              "Content-type": "application/json"
            },
            body: json.encode(login));

    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(response.body);

    Map responseList = jsonDecode(response.body);

    if (responseList["code"] == 1) {
      prefs.setBool('isLoggedIn', responseList['isLoggedIn']);
      prefs.setString('name', responseList['name']);
      prefs.setString('email', responseList['email']);
      prefs.setInt('id', responseList['id']);
      prefs.setString('address', responseList['adress']);

      Navigator.pushNamed(context, '/home');
    } else if (responseList["code"] == 2) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Login Failed"),
              content: Text("Wrong Password"),
            );
          });
    } else if (responseList["code"] == 3) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Login Failed"),
              content: Text("Wrong Username"),
            );
          });
    }
  }

  report(BuildContext context, notes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var location = new Location();
    LocationData position;
    position = await location.getLocation();
    
    Map report = {
    'special_notes' : notes,
    'reporter_id' : prefs.getInt('id'),
    'lng' : position.longitude.toDouble(),
    'lat' : position.latitude.toDouble()};

    http.Response response =
        await http.post(config.url + "/reports",
            headers: {
              "Accept": "application/json",
              "Content-type": "application/json"
            },
            body: json.encode(report));
    
    Map responseBody = jsonDecode(response.body);
    
    Navigator.pushNamed(context, "/home");

    showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Message"),
              content: Text(responseBody["message"]),
            );
          });
    
  }

  register(String name, String phone, String email, String password, String address) async {
    Map user = {
      "name" : name,
      "phone" : phone,
      "email" : email,
      "password" : password,
      "address" : address
    };

    http.Response response =
        await http.post(config.url + "/nonstaffusers",
            headers: {
              "Accept": "application/json",
              "Content-type": "application/json"
            },
            body: json.encode(user));

    print(response.body);
  }
}
