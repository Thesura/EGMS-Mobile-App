import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:egms_app_2/apiConfig.dart' as config;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:egms_app_2/repair.dart';

class Services {
  Future<List> getOutages() async {
    http.Response response = await http.get(config.url + "/outages",
        headers: {"Accept": "application/json"});

    List outages = jsonDecode(response.body);

    print(outages[0]);

    return outages;
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

  fixOutage(BuildContext context, outage) async {
  
    Map outageFixed = {
      'id': outage[0],
      'area': outage[1],
      'date': outage[2],
      'status': 'Fixed'
    };

    http.Response response =
        await http.put(config.url + "/outages",
            headers: {
              "Accept": "application/json",
              "Content-type": "application/json"
            },
            body: json.encode(outageFixed));

    print(outageFixed.toString());

    Navigator.pushNamed(context, '/outages');
  }

  repairOutage(BuildContext context, outage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(outage != null){

      List outageReturn = List();
      outageReturn.insert(0, outage['id'].toString());
      outageReturn.insert(1, outage['area'].toString());
      outageReturn.insert(2, outage['date']);
      outageReturn.insert(3, outage['status']);

      Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RepairPage(outage: outageReturn),
    ));
    }else print('Outage is empty');
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
        await http.post(config.url + "/staffusers/login",
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
      prefs.setInt('area', responseList['area']);

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

  report(String notes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var location = new Location();
    LocationData position;
    position = await location.getLocation();
    var dateTime = new DateTime.now();
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
    print(report);
    print(response.statusCode);
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
