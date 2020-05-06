import 'package:flutter/material.dart';
import 'package:egms_app_2/Services.dart';

class OutagesPage extends StatefulWidget {
  OutagesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OutagesPageState createState() => _OutagesPageState();
}

class _OutagesPageState extends State<OutagesPage> {
  TextStyle style = TextStyle(fontFamily: 'Motserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    var services = Services();

    final selectButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        minWidth: 10,
        onPressed: () {},
        child: Text(
          "->",
          textAlign: TextAlign.center,
          style: style.copyWith(color: Colors.white),
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Outages"),
          backgroundColor: Colors.egmsBg,
        ),
        body: new FutureBuilder(
            future: services.getOutages(),
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
                            DataColumn(label: Text("Area")),
                            DataColumn(label: Text("Date")),
                            DataColumn(label: Text("Status")),
                            DataColumn(label: Text("Select"))
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(content[index]['area'].toString())),
                              DataCell(Text(content[index]['date'])),
                              DataCell(Text(content[index]['status'])),
                              DataCell(Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(15.0),
                                color: Color(0xff01A0C7),
                                child: MaterialButton(
                                  padding: EdgeInsets.all(0),
                                  minWidth: 10,
                                  onPressed: () {
                                    services.repairOutage(context, content[index]);
                                  },
                                  child: Text(
                                    "->",
                                    textAlign: TextAlign.center,
                                    style: style.copyWith(color: Colors.white),
                                  ),
                                ),
                              ))
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
