import 'package:Help_Desk/Screens/Home/components/person.dart';
import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:Help_Desk/report/detail/request.dart';
import 'package:flutter/material.dart';

class MyRP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "My Report",
                    style: TextStyle(
                        fontFamily: 'Acme',
                        fontWeight: FontWeight.bold,
                        color: kPrimaryEnd,
                        fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.report_gmailerrorred_outlined,
                      color: kPrimaryEnd,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: new FutureBuilder<List<Report>>(
              future: downloadJSONMyReport(),
              //we pass a BuildContext and an AsyncSnapshot object which is an
              //Immutable representation of the most recent interaction with
              //an asynchronous computation.
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Report> reports = snapshot.data;
                  return new Person(reports);
                } else if (snapshot.hasError) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Null"),
                          Icon(
                            Icons.no_cell_sharp,
                            size: 30,
                          ),
                        ],
                      ));
                }
                //return  a circular progress indicator.
                return Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          )
        ],
      )
          //FutureBuilder is a widget that builds itself based on the latest snapshot
          // of interaction with a Future.

          ),
    );
  }
}
