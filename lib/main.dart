import 'package:Help_Desk/Screens/Home/add.dart';
import 'package:Help_Desk/Screens/Home/employee.dart';
import 'package:Help_Desk/Screens/Home/load.dart';
import 'package:Help_Desk/Screens/Home/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() => runApp(EasyLocalization(
      child: MyApp(),
      path: "resources/langs",
      supportedLocales: [Locale('vi', 'VN'), Locale('en', 'EN')],
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: LoadScreens(),
    );
  }
}
