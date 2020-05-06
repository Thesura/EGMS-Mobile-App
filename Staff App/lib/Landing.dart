import 'package:flutter/material.dart';
import 'package:egms_app_2/Services.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextStyle style = TextStyle(fontFamily: 'Motserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

    var services = Services();

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          services.checkSession(context);
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("EGMS"),
        backgroundColor: Colors.egmsBg,
      ),
      body: Center(
        child: Container(
          color: Colors.egmsBg,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(25.0, 60.0, 25.0, 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 180.0,
                  child: Image.asset(
                    "assets/images/logo1.png",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 65.0),
                loginButton,
                SizedBox(
                  height: 25.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
