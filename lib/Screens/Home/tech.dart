import 'dart:async';

import 'package:Help_Desk/Screens/Home/Approd.dart';

import 'package:Help_Desk/Screens/Home/notification.dart';
import 'package:Help_Desk/Screens/Home/process.dart';
import 'package:Help_Desk/Screens/Home/setting.dart';
import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:Help_Desk/report/detail/request.dart';
import 'package:Help_Desk/straintion/right_left.dart';

import 'package:flutter/material.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;

import 'package:easy_localization/easy_localization.dart';

import 'history.dart';

class Tech extends StatefulWidget {
  final List<Report> report;

  Tech({Key key, this.report}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<Tech> {
  final List<Widget> _children = [
    ListRP_Tech(),
    Process(),
    Approd(),
    Setting(),
  ];
  Future<List<NotificationRB>> _future;

  int _page = 0;
  TextEditingController searchController = TextEditingController();
  void initState() {
    super.initState();
    setUpTimedFetch();
  }

  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 2000), (timer) {
      setState(() {
        _future = notification();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.775,
                child: TextField(
                  style: TextStyle(
                    color: kPrimaryWhite,
                  ),
                  controller: searchController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: 'Acme',
                    ),
                    hintText: "search".tr().toString(),
                    prefixIcon: Icon(Icons.search, color: kPrimaryWhite),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryNone),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryNone),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: kPrimaryWhite,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context, SlideRightRoute(page: Notifi()));
                      }),
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(left: 8, top: 10),
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffc32c37),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Center(
                          child: new FutureBuilder<List<NotificationRB>>(
                            future: notification(),
                            //we pass a BuildContext and an AsyncSnapshot object which is an
                            //Immutable representation of the most recent interaction with
                            //an asynchronous computation.
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<NotificationRB> notifis = snapshot.data;
                                List<NotificationRB> notificheck = [];
                                notifis.forEach((element) {
                                  if (element.checkey == 0)
                                    notificheck.add(element);
                                });
                                return new Text(
                                  notificheck.length.toString(),
                                  style: TextStyle(fontSize: 10),
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  "0",
                                  style: TextStyle(fontSize: 10),
                                );
                              }
                              //return  a circular progress indicator.
                              return Text(
                                "",
                                style: TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[kPrimaryEnd, kPrimaryStart])),
        ),
      ),
      backgroundColor: kPrimaryBlue,
      body: _children[_page],
      bottomNavigationBar: GradientBottomNavigationBar(
        backgroundColorStart: kPrimaryStart,
        backgroundColorEnd: kPrimaryEnd,
        fixedColor: kPrimaryWhite,
        currentIndex: _page,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              "home".tr().toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            title: Text(
              "work".tr().toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text(
              "report".tr().toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text(
              "setting".tr().toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
