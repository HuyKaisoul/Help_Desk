import 'package:Help_Desk/Screens/Home/components/list_notifi.dart';
import 'package:Help_Desk/Screens/Home/employee.dart';
import 'package:Help_Desk/Screens/Home/tech.dart';
import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:Help_Desk/report/detail/request.dart';
import 'package:Help_Desk/straintion/left_right.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

class Notifi extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Notifi> {
  Future<NotificationRB> _notifi() async {
    int type = await FlutterSession().get("type");

    final response = await http.post(url + "api/updatenot", body: {
      "username": await FlutterSession().get("username"),
    });
    if (type == 0) {
      Navigator.push(context, SlideRightRoute(page: Employee()));
    } else if (type == 1) {
      Navigator.push(context, SlideRightRoute(page: Tech()));
    } else {}
  }

  Future<NotificationRB> _clear() async {
    int type = await FlutterSession().get("type");

    final response = await http.post(url + "api/clearnot", body: {
      "username": await FlutterSession().get("username"),
    });
    if (response.body == '0') {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              content: Row(
                children: <Widget>[
                  Text("success".tr().toString()),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              content: Row(
                children: <Widget>[
                  Text("fail".tr().toString()),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    _notifi();
                  }),
              Text("notifitcation".tr().toString()),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _clear();
                  }),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: kPrimaryBlue,
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
                      "mynot".tr().toString(),
                      style: TextStyle(
                          fontFamily: 'Acme',
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.notification_important,
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
