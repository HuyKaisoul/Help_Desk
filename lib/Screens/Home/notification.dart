import 'package:Help_Desk/Screens/Home/components/list_notifi.dart';
import 'package:Help_Desk/Screens/Home/employee.dart';
import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:Help_Desk/report/detail/request.dart';
import 'package:Help_Desk/straintion/left_right.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class Notifi extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Notifi> {
  Future<NotificationRB> _notifi() async {
    final response = await http.post(
        "http://helpdesksolutionszz.000webhostapp.com/ConnectPHP/updatenot.php",
        body: {
          "username": await FlutterSession().get("username"),
        });
    Navigator.push(context, SlideRightRoute(page: Employee()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  _notifi();
                }),
            Text("Notifitcation"),
          ],
        )),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "My Notifitcation",
                      style: TextStyle(
                          fontFamily: 'Acme',
                          fontWeight: FontWeight.bold,
                          color: kPrimaryEnd,
                          fontSize: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.notification_important,
                        color: kPrimaryEnd,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: new FutureBuilder<List<NotificationRB>>(
                future: notification(),
                //we pass a BuildContext and an AsyncSnapshot object which is an
                //Immutable representation of the most recent interaction with
                //an asynchronous computation.
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<NotificationRB> notifis = snapshot.data;
                    return new ListNot(notifis);
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
            ),
          ],
        ),
      ),
    );
  }
}