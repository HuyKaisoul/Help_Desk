import 'package:Help_Desk/Screens/Home/login.dart';
import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/straintion/left_right.dart';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  @override
  _MenuOptionsScreenState createState() => _MenuOptionsScreenState();
}

class _MenuOptionsScreenState extends State<Setting> {
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("langdr".tr().toString()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Text("Việt Nam"),
                        ),
                        Image.asset(
                          "asset/img/vn.png",
                          width: 50,
                        )
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        EasyLocalization.of(context).locale =
                            Locale('vi', 'VN');
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Text("English"),
                        ),
                        Image.asset(
                          "asset/img/en.png",
                          width: 50,
                        )
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        EasyLocalization.of(context).locale =
                            Locale('en', 'EN');
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        Text(
          "general".tr().toString(),
          style: TextStyle(
              fontFamily: 'Acme',
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        Card(
          color: kPrimaryWhite,
          elevation: 4.0,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: Colors.green,
                ),
                title: Text("lang".tr().toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("idlang".tr().toString()),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                onTap: () async {
                  _showChoiceDialog(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: Text("logout".tr().toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[Icon(Icons.arrow_forward_ios)],
                ),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs?.setString("isLoggedIn", '');
                  var session = FlutterSession();
                  await session.set("username", "");
                  await session.set("type", "");
                  Navigator.push(context, SlideRightRoute(page: LoginScreen()));
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "system".tr().toString(),
          style: TextStyle(
              fontFamily: 'Acme',
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        Card(
          color: kPrimaryWhite,
          elevation: 4.0,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.phone_android,
                  color: kPrimaryColor,
                ),
                title: Text("version".tr().toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("1.0.0"),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.file_upload,
                  color: Colors.orange,
                ),
                title: Text("upgrade".tr().toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Text(
                          "3",
                          style: TextStyle(
                            fontFamily: "Amce",
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
