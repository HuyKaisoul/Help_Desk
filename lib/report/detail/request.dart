import 'dart:convert';

import 'package:Help_Desk/constrain.dart';
import 'package:flutter_session/flutter_session.dart';

import 'head_contain.dart';
import 'package:http/http.dart' as http;

Future<List<Report>> downloadJSON() async {
  final jsonEndpoint = url + "api/retrieve";

  final response = await http.get(jsonEndpoint);

  if (response.statusCode == 200) {
    List reports = json.decode(response.body);
    return reports.map((report) => new Report.fromJson(report)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<List<Report>> downloadJSONMyReport() async {
  final jsonEndpoint = url + "api/myreport";

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
  final jsonEndpoint = url + "api/notification";

  final response = await http.post(
    jsonEndpoint,
    body: {
      "username": await FlutterSession().get("username"),
    },
  );
  if (response.statusCode == 200) {
    List notifi = json.decode(response.body);
    return notifi.map((notifi) => new NotificationRB.fromJson(notifi)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<List<Messages>> messages(int id) async {
  final jsonEndpointwww = url + "api/mess";
  var bodyEncoded = json.encode(id);
  final responsess = await http.post(jsonEndpointwww, body: {
    "id": bodyEncoded,
  });
  print(id);
  if (responsess.statusCode == 200) {
    List message = json.decode(responsess.body);
    return message.map((message) => new Messages.fromJson(message)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}
