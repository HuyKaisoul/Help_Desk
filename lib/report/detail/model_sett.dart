import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Option {
  Icon icon;
  String title;
  String subtitle;

  Option({this.icon, this.title, this.subtitle});
}

final options = [
  Option(
    icon: Icon(Icons.language, size: 40.0),
    title: 'lang'.tr().toString(),
    subtitle: 'langdr'.tr().toString() + '.',
  ),
  Option(
    icon: Icon(Icons.logout, size: 40.0),
    title: 'logout'.tr().toString(),
    subtitle: 'logoutdr'.tr().toString() + '.',
  ),
];
