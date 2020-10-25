import 'package:Help_Desk/Screens/Home/components/person.dart';
import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:Help_Desk/report/detail/request_tech.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'components/app.dart';

class Approd extends StatelessWidget {
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
                    "suggested".tr().toString(),
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
              future: downloadJSONApprod(),
              //we pass a BuildContext and an AsyncSnapshot object which is an
              //Immutable representation of the most recent interaction with
              //an asynchronous computation.
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Report> reports = snapshot.data;
                  return new Approded(reports);
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Container(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                //return  a circular progress indicator.
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
