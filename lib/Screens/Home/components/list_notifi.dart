import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:flutter/material.dart';

class ListNot extends StatelessWidget {
  final List<NotificationRB> notifi;

  ListNot(this.notifi);
  String getText(int status) {
    String temp;
    if (status == 0) {
      temp = ('Your report  was Posted');
    } else if (status == 1) {
      temp = 'Your report was Approved';
    } else if (status == 2) {
      temp = 'Your report was Processing';
    } else {
      temp = 'Your report was Fixed';
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          child: ListView.builder(
            itemCount: notifi.length,
            itemBuilder: (context, int currentIndex) {
              return listViewNoti(notifi[currentIndex], context);
            },
          ),
        ),
      ),
    );
  }

  Widget listViewNoti(NotificationRB notifi, BuildContext context) {
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
                      SizedBox(height: 5.0),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Row(
                            children: <Widget>[
                              Text(
                                // "Your report [" +
                                //     notifi.post_id +
                                //     "] was " +
                                //     getText(notifi.status),
                                // "haaaaaaaaahaaaaaaaaaaaaaaaaaaa",
                                getText(notifi.status),
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
