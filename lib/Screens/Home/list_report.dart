import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:Help_Desk/report/detail/request.dart';
import 'package:flutter/material.dart';

import 'components/home.dart';

class ListRP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      //FutureBuilder is a widget that builds itself based on the latest snapshot
      // of interaction with a Future.
      child: new FutureBuilder<List<Report>>(
        future: downloadJSON(),
        //we pass a BuildContext and an AsyncSnapshot object which is an
        //Immutable representation of the most recent interaction with
        //an asynchronous computation.
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Report> reports = snapshot.data;

            return new Home(reports);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          //return  a circular progress indicator.
          return new CircularProgressIndicator();
        },
      ),
    );
  }
}
