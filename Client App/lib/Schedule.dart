import 'package:flutter/material.dart';
import 'package:egms_app/Services.dart' as Services;

import 'dart:convert';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  TextStyle style = TextStyle(fontFamily: 'Motserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    var scheduleService = new Services.Services();

    // Future<List> schedule = scheduleService.getSchedule();

    // final table = DataTable(
    // columns: [
    //   DataColumn(label: Text("Type")),
    //   DataColumn(label: Text("Area")),
    //   DataColumn(label: Text("Start")),
    //   DataColumn(label: Text("End"))
    // ],
    // rows: [

    // ],

    // );

    final displayButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Display",
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
          title: Text("Schedule"),
          backgroundColor: Colors.egmsBg,
        ),
        body: new FutureBuilder(
            future: scheduleService.getSchedule(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) return new Container();
              List content = snapshot.data;
              return new ListView.builder(
                scrollDirection: Axis.vertical,
                padding: new EdgeInsets.all(0.0),
                itemCount: content.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                      alignment: FractionalOffset.center,
                      margin: new EdgeInsets.only(bottom: 6.0),
                      padding: new EdgeInsets.all(0.0),
                      color: Colors.black12,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: new DataTable(
                          columnSpacing: 8.0,
                          columns: [
                            DataColumn(label: Text("Type")),
                            DataColumn(label: Text("Area")),
                            DataColumn(label: Text("Start")),
                            DataColumn(label: Text("End"))
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(content[index]['type'])),
                              DataCell(Text(content[index]['areaName'])),
                              DataCell(Text(content[index]['start_date_time'])),
                              DataCell(Text(content[index]['end_date_time']))
                            ])
                          ],
                        ),
                      ));
                },
              );
            })
        // body: Center(
        //   child: Container(
        //     color: Colors.egmsBg,
        //     child: SingleChildScrollView(
        //       padding: const EdgeInsets.fromLTRB(25.0, 60.0, 25.0, 150.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           SizedBox(height: 45.0),
        //           displayButton,
        //           backButton,
        //           SizedBox(
        //             height: 15.0,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
