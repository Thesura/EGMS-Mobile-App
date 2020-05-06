import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  TextStyle style = TextStyle(fontFamily: 'Motserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
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

    Completer<GoogleMapController> mapController = Completer();

    final CameraPosition position = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

    final GoogleMap map = new GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: position,
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);
        });

    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        backgroundColor: Colors.egmsBg,
      ),
      body: Center(
        child: Container(
          color: Colors.egmsBg,
          child: Scaffold(
            backgroundColor: Colors.egmsBg,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 350,
                  child: map,
                )
                ,
                SizedBox(
                  height: 25.0,
                ),
                backButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
