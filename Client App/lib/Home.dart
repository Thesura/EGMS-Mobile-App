import 'package:flutter/material.dart';
import 'package:egms_app/Services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle style = TextStyle(fontFamily: 'Motserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

    var services = Services();

    final reportButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        onPressed: () {
          Navigator.pushNamed(context, '/report');
        },
        child: Text("Report",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final scheduleButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        onPressed: () {
          Navigator.pushNamed(context, '/schedule');
        },
        child: Text("Schedule",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

      final mapButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        onPressed: () {
          Navigator.pushNamed(context, '/map');
        },
        child: Text("Status Map",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final logoutButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.egmsBg,
      child: MaterialButton(
        onPressed: () {
          services.logout(context);
        },
        child: Text("Logout",
            textAlign: TextAlign.center,            
            style: style.copyWith(
                color: Colors.white)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("EGMS"),
        backgroundColor: Colors.egmsBg,
        actions: <Widget>[
          logoutButton
        ],
      ),
      body: Center(
        child: Container(
          color: Colors.egmsBg,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(25.0, 60.0, 25.0, 150.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[                
                SizedBox(height: 45.0),
                reportButton,
                SizedBox(
                  height: 15.0,
                ),
                scheduleButton,
                SizedBox(
                  height: 15.0,
                ),
                mapButton,
                SizedBox(
                  height: 15.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
