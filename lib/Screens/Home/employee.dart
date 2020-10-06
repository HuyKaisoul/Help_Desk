import 'package:Help_Desk/Screens/Home/add.dart';
import 'package:Help_Desk/Screens/Home/home.dart';
import 'package:Help_Desk/Screens/Home/list_report.dart';
import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:Help_Desk/report/detail/request.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Employee extends StatefulWidget {
  final List<Report> report;

  Employee({Key key, this.report}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<Employee> {
  final List<Widget> _children = [
    ListRP(),
    AddScreen(),
  ];
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  TextEditingController searchController = TextEditingController();
  void check() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: TextField(
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                  controller: searchController,
                  onTap: () {},
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: 'Acme',
                    ),
                    hintText: "Search...",
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
      body: _children[_page],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: kPrimaryWhite,
        color: kPrimaryColor,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: kPrimaryWhite),
          Icon(Icons.add_circle, size: 30, color: kPrimaryWhite),
          Icon(Icons.person, size: 30, color: kPrimaryWhite),
          Icon(Icons.settings, size: 30, color: kPrimaryWhite),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
