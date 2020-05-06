import 'package:flutter/material.dart';
import 'package:egms_app/Services.dart';

class ReportPage extends StatefulWidget {
  ReportPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  TextStyle style = TextStyle(fontFamily: 'Motserrat', fontSize: 20.0);

  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var services = Services();

    final specialNotesField = TextField(
      obscureText: false,
      style: style,
      controller: notesController,
      maxLines: 4,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Special Notes or information(Optional)',
          filled: true,
          fillColor: Colors.white,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final reportButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          services.report(context, notesController.text);
        },
        child: Text("Report",
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
        title: Text("Report"),
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
                specialNotesField,
                SizedBox(
                  height: 25.0,
                ),
                reportButton,
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
