import 'dart:async';

import 'package:Help_Desk/Screens/Home/login.dart';
import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/straintion/right_left.dart';
import 'package:flutter/material.dart';

class LoadScreens extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Load();
  }
}

class Load extends State<LoadScreens> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      // 5s over, navigate to a new page
      Navigator.push(context, SlideRightRoute(page: LoginScreen()));
    });
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
                  child: Text('desin by',
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
