import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

import 'detailMess.dart';

class Mess extends StatelessWidget {
  final List<Messages> mess;

  Mess(this.mess);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          child: ListView.builder(
            itemCount: mess.length,
            itemBuilder: (context, int currentIndex) {
              return listViewReport(mess[currentIndex], context);
            },
          ),
        ),
      ),
    );
  }

  Color getColor(int status) {
    if (status == 0) {
      return Colors.blue;
    } else if (status == 1) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  Future<String> getText(int status, String username) async {
    String checkname = await FlutterSession().get("username");
    if (status == 0) {
      if (username == checkname) {
        return ': Me';
      } else {
        return ': Employee';
      }
    } else if (status == 1) {
      return ': Technical';
    } else {
      return ': Admin';
    }
  }

  String text = "";
  Widget listViewReport(Messages mess, BuildContext context) {
    return new ListTile(
      title: new Card(
        elevation: 10.0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          mess.date,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Text(
                          mess.containts,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: 5.0),
                  Container(
                    width: 70.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: getColor(mess.user_type),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    alignment: Alignment.center,
                    child: FutureBuilder(
                        future: getText(mess.user_type, mess.username),
                        builder: (context, snapshot) {
                          if (snapshot.hasData)
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          return Container(
                            width: 0.0,
                            height: 0.0,
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        //We start by creating a Page Route.
        //A MaterialPageRoute is a modal route that replaces the entire
        //screen with a platform-adaptive transition.
        var route = new MaterialPageRoute(
          builder: (BuildContext context) => new MessTail(value: mess),
        );
        //A Navigator is a widget that manages a set of child widgets with
        //stack discipline.It allows us navigate pages.
        Navigator.of(context).push(route);
      },
    );
  }
}
