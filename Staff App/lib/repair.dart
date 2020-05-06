import 'package:flutter/material.dart';
import 'package:egms_app_2/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepairPage extends StatefulWidget {
  RepairPage({Key key, this.title, @required this.outage}) : super(key: key);

  final List outage;
  final String title;

  @override
  _RepairPageState createState() => _RepairPageState(outage);
}

class _RepairPageState extends State<RepairPage> {
  TextStyle style = TextStyle(fontFamily: 'Motserrat', fontSize: 20.0);

  _RepairPageState(this.outage);

  final List outage;

  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var services = Services();

    print(outage);

    final fixedButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          services.fixOutage(context, outage);
        },
        child: Text("Fixed",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final backButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
        child: Text("Back",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Repair"),
        backgroundColor: Colors.egmsBg,
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
                SizedBox(
                  height: 45.0
                  ),
                  Text("Repair Outage", style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                SizedBox(
                  height: 25.0,
                ),
                Text("Area ID: "+outage[1], style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                SizedBox(
                  height: 25.0,
                ),
                Text("Status: "+outage[3], style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
                SizedBox(
                  height: 25.0,
                ),
                fixedButton,
                SizedBox(
                  height: 15.0,
                ),
                backButton,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
