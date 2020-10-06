import 'package:Help_Desk/Screens/Home/detail.dart';
import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:flutter/material.dart';

class RecentReport extends StatelessWidget {
  final List<Report> report;

  RecentReport(this.report);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: report.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(report[currentIndex], context);
      },
    );
  }

  Widget createViewItem(Report report, BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          new ListTile(
              title: new Card(
                elevation: 5.0,
                child: new Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image(
                            image: NetworkImage(report.imageUrl),
                            width: 80,
                            height: 80,
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                report.title,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
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
                    ],
                  ),
                ),
              ),
              onTap: () {
                //We start by creating a Page Route.
                //A MaterialPageRoute is a modal route that replaces the entire
                //screen with a platform-adaptive transition.
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new SecondScreen(value: report),
                );
                //A Navigator is a widget that manages a set of child widgets with
                //stack discipline.It allows us navigate pages.
                Navigator.of(context).push(route);
              }),
        ],
      ),
    );
  }
}
