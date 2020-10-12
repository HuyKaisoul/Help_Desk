import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:flutter/material.dart';

import '../detail.dart';

class Home extends StatelessWidget {
  final List<Report> report;

  Home(this.report);

  Widget build(context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 2.0, right: 2.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Search current',
                            style: TextStyle(
                              color: kPrimaryGray,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontFamily: 'Acme',
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.more_horiz,
                            ),
                            iconSize: 30.0,
                            color: kPrimaryGray,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80.0,
                      child: ListView.builder(
                        padding: EdgeInsets.only(left: 10.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: report.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SecondScreen(
                                  value: report[index],
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 35.0,
                                    backgroundImage:
                                        NetworkImage(report[index].imageUrl),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              child: ListView.builder(
                itemCount: report.length,
                itemBuilder: (context, int currentIndex) {
                  return listViewReport(report[currentIndex], context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget listViewReport(Report report, BuildContext context) {
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
                  CircleAvatar(
                    radius: 35.0,
                    backgroundImage: NetworkImage(report.imageUrl),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Text(
                          report.title,
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
                          report.description,
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
                    width: 60.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Complete',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
          builder: (BuildContext context) => new SecondScreen(value: report),
        );
        //A Navigator is a widget that manages a set of child widgets with
        //stack discipline.It allows us navigate pages.
        Navigator.of(context).push(route);
      },
    );
  }
}
