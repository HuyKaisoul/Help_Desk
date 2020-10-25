import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_session/flutter_session.dart';

class ListNot extends StatelessWidget {
  final List<NotificationRB> notifi;

  ListNot(this.notifi);

  Future<String> getNotifi(int status) async {
    String type = await FlutterSession().get("type");
    print(status);
    if (type == '0') {
      if (status == 0) {
        return "notifipost".tr().toString();
      } else if (status == 1) {
        return 'notifiapp'.tr().toString();
      } else if (status == 2) {
        return 'notifipro'.tr().toString();
      } else {
        return 'notififix'.tr().toString();
      }
    } else if (type == '1') {
      if (status == 1) {
        return 'notifiapptech'.tr().toString();
      } else if (status == 2) {
        return 'notifiprotech'.tr().toString();
      } else {
        return 'notififixtech'.tr().toString();
      }
    } else {}
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
                              FutureBuilder(
                                future: getNotifi(notifi.status),
                                builder: (context, snapshot) {
                                  print(snapshot.data);
                                  if (snapshot.hasData) {
                                    return Text(
                                      // "Your report [" +
                                      //     notifi.post_id +
                                      //     "] was " +
                                      //     getText(notifi.status),
                                      // "haaaaaaaaahaaaaaaaaaaaaaaaaaaa",
                                      snapshot.data,
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
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
