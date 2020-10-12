import 'dart:convert';

import 'package:flutter_session/flutter_session.dart';

import 'head_contain.dart';
import 'package:http/http.dart' as http;

Future<List<Report>> downloadJSON() async {
  final jsonEndpoint =
      "http://helpdesksolutionszz.000webhostapp.com/ConnectPHP/retrieve.php";

  final response = await http.get(jsonEndpoint);

  if (response.statusCode == 200) {
    List reports = json.decode(response.body);
    return reports.map((report) => new Report.fromJson(report)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<List<Report>> downloadJSONMyReport() async {
  final jsonEndpoint =
      "http://helpdesksolutionszz.000webhostapp.com/ConnectPHP/myreport.php";

  final response = await http.post(jsonEndpoint, body: {
    "username": await FlutterSession().get("username"),
  });
  if (response.statusCode == 200) {
    List reports = json.decode(response.body);
    return reports.map((report) => new Report.fromJson(report)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<List<NotificationRB>> notification() async {
  final jsonEndpoint =
      "http://helpdesksolutionszz.000webhostapp.com/ConnectPHP/notification.php";

  final response = await http.post(jsonEndpoint, body: {
    "username": await FlutterSession().get("username"),
  });
  if (response.statusCode == 200) {
    List notifi = json.decode(response.body);
    return notifi.map((notifi) => new NotificationRB.fromJson(notifi)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}
