import 'package:Help_Desk/Screens/Home/detail.dart';
import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:flutter/material.dart';

class Approded extends StatelessWidget {
  final List<Report> report;

  Approded(this.report);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }

  Color getColor(int status) {
    if (status == 0) {
      return Colors.red;
    } else if (status == 1) {
      return Colors.blue;
    } else if (status == 2) {
      return kPrimaryBlue;
    } else {
      return Colors.green;
    }
  }

  String getText(int status) {
    if (status == 0) {
      return 'Posted';
    } else if (status == 1) {
      return 'Approved';
    } else if (status == 2) {
      return 'Processing';
    } else {
      return 'Fixed';
    }
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
                    width: 70.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: getColor(report.status),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      getText(report.status),
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
