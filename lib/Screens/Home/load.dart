import 'dart:async';

import 'package:Help_Desk/Screens/Home/admin.dart';
import 'package:Help_Desk/Screens/Home/employee.dart';
import 'package:Help_Desk/Screens/Home/login.dart';
import 'package:Help_Desk/Screens/Home/tech.dart';
import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/straintion/right_left.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadScreens extends StatefulWidget {
  @override
  Load createState() => Load();
}

class Load extends State<LoadScreens> {
  Future<Widget> getWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getString('isLoggedIn') ?? '999';

    // 5s over, navigate to a new page
    if (status == '0') {
      return Employee();
    } else if (status == '1') {
      return Tech();
    } else if (status == '2') {
      return Admin();
    } else {
      return LoginScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
      () {
        // 5s over, navigate to a new page
        Navigator.push(
          context,
          SlideRightRoute(
            page: FutureBuilder(
              future: getWidget(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data;
                } else {
                  return LoginScreen();
                }
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider backgroundImage = AssetImage("asset/img/background.jpg");
    backgroundImage.resolve(createLocalImageConfiguration(context));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Help Desk',
                    style: TextStyle(
                        color: kPrimaryWhite,
                        fontSize: 60,
                        fontFamily: 'Acme')),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('design'.tr().toString(),
                      style: TextStyle(
                          color: kPrimaryWhite,
                          fontSize: 12,
                          fontFamily: 'Acme')),
                ),
                Text(
                  'M.Thong - N.Huy',
                  style: TextStyle(
                      color: kPrimaryWhite, fontSize: 15, fontFamily: 'Acme'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
